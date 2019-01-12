# frozen_string_literal: true

# manages events in API
class Api::V1::EventsController < ApiController
  before_action :set_event, only: [:cancel, :publish, :cancel, :show, :update]
  skip_before_action :authenticate_request!, only: [:public]

  # GET /events
  # GET /events.json
  def index
    paginate = pagination_params(params)
    team_ids = current_team

    events = Event.where(team_id: team_ids)
                  .order(paginate[:order_by])
                  .page(paginate[:page])
                  .per(paginate[:per_page])
    events = filter_events(events)

    serialized = ActiveModelSerializers::SerializableResource.new(events)
    render_success(serialized, pagination_dict(events))
  end

  # GET /events/1
  # GET /events/1.json
  def show
    render_success EventSerializer.new(@event).as_json
  end

  # GET /events/1
  # GET /events/1.json
  def public
    @event = Event.includes(registration_form: [registration_questions: [:registration_options]])
                  .find_by(internal_name: params[:event_id])

    Time.use_zone(@event.time_zone) do
      if params[:preview] == "true" || @event&.published?
        I18n.with_locale(@event.language.key) do
          render_success PublicEventSerializer.new(@event).as_json
        end
      else
        render_error(RESPONSE_CODE[:not_found], "Event has expired")
      end
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      render_success(EventSerializer.new(@event).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity], @event.errors.full_messages.join(","), @event.errors)
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.update(event_params)
      render_success(EventSerializer.new(@event).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity], @event.errors.full_messages.join(","), @event.errors)
    end
  end

  # PATCH/PUT /events/1/cancel
  # PATCH/PUT /events/1/cancel.json
  def cancel
    if @event.unpublish!
      render_success(EventSerializer.new(@event).as_json, message: "Event is now unpublished")
    else
      render_error(RESPONSE_CODE[:unprocessable_entity], @event.errors.full_messages.join(","), @event.errors)
    end
  end

  # PATCH/PUT /events/1/publish
  # PATCH/PUT /events/1/publish.json
  def publish
    if @event.publish!
      render_success(EventSerializer.new(@event).as_json, message: "Event is now published")
    else
      render_error(RESPONSE_CODE[:unprocessable_entity], @event.errors.full_messages.join(","), @event.errors)
    end
  end

  def destroy_all
    if current_team.nil?
      render_error(RESPONSE_CODE[:unprocessable_entity], "no team?", params[:team_id])
      return
    end

    params[:events].each do |event|
      event = current_team.events.find(event[:id])
      unless event.destroy
        render_error(RESPONSE_CODE[:unprocessable_entity],
                     event.errors.full_messages.join(","),
                     event.errors)
        return
      end
    end
    render_success({success: true, message: "coco"})
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = current_team.events.find(params[:id] || params[:event_id])
  end

  def filter_events(events)
    case params[:filter]
    when "draft"
      events = events.draft
    when "upcoming"
      events = events.upcoming Time.zone.now #.end_of_day
    when "past"
      events = events.past Time.zone.now #.end_of_day
    end
    events = events.where(group_id: params[:group_id]) if params[:group_id].present?
    events
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:team_id, :group_id, :status, :internal_name, :public_name, :language_id,
                                  :location, :when,
                                  :from_name, :from_address,
                                  :city, :country, :registration_start_date, :registration_close_date,
                                  :additional_data, :capacity, :event_start_date, :event_end_date,
                                  :at_capacity_action, :signup_notification_recipients, :header_content_id,
                                  :registration_form_id, :footer_content_id, :time_zone, :description)
  end
end
