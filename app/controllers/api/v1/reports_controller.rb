# frozen_string_literal: true

# API for retrieving reports
class Api::V1::ReportsController < ApiController
  before_action :set_event, only: [:download]
  before_action :set_event_from_user, only: [:index]

  # GET /events/2/reports
  def index
    paginate = pagination_params(params)
    # get registrants
    @registrants = Registrant.where(event_id: @event.id)
                             .order(paginate[:order_by])
                             .page(paginate[:page])
                             .per(paginate[:per_page])
    #serialize
    serialized = ActiveModelSerializers::SerializableResource.new(@registrants)
    render_success(serialized, pagination_dict(@registrants))
  end

  # GET /events/x/reports/1/download
  def download
    send_data build_spreadsheet(@event.export), filename: "dir.xlsx"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  # get event from user
  def set_event_from_user
    @event = Event.all.where(team_id: current_team.id).find(params[:event_id])
  end
end
