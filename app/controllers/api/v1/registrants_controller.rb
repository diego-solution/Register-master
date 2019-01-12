# frozen_string_literal: true

# API for creating new registrants and confirmn presence
class Api::V1::RegistrantsController < ApiController
  before_action :set_event_by_internal_name, only: [:create, :confirm]
  before_action :set_registrant, only: [:confirm]
  skip_before_action :authenticate_request!, only: [:create, :confirm]

  # create a new registrant for event
  def create
    @registrant = new_registrant_from_event

    if @registrant.save
      render_success(RegistrantSerializer.new(@registrant).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @registrant.errors.full_messages.join(","),
                   @registrant.errors)
    end
  end

  # PUT /registrants/confirm?token=a&action=b
  def confirm
    set_registrant
    @registrant.confirm_registration(params[:option])

    if @registrant.save
      render_success(RegistrantSerializer.new(@registrant).as_json,
                     message: success_msg_for_confirmation)
    else
      render_error(RESPONSE_CODE[:bad_request],
                   error_msg_for_confirmation,
                   @registrant.errors)
    end
  end

  private

  def success_msg_for_confirmation
    key = @registrant.confirmed? ? "confirmation.form.confirmed" : "confirmation.form.canceled"
    Translation.find_or_init_by_key(@event.language_id, @event.team_id, key).try(:text)
  end

  def error_msg_for_confirmation
    key = @registrant.registered? ? "confirmation.form.error" : "confirmation.form.already"
    Translation.find_or_init_by_key(@event.language_id, @event.team_id, key).try(:text)
  end

  def new_registrant_from_event
    registrant = Registrant.new(event_registrant_params)
    registrant.event = @event
    registrant.team  = @event.team
    registrant.referrer = get_referrer(params[:token])
    registrant
  end

  # save referrer information from form
  def get_referrer(token)
    return nil if token.blank?
    Referrer.find_by token: params[:token]
  end

  def set_registrant
    @registrant = Registrant.find_by!(token: params[:registrant_id])
    render_error(RESPONSE_CODE[:forbidden], I18n.t("api.errors.forbidden")) if @registrant.event != @event
  end

  def set_event_by_internal_name
    @event = Event.includes(registration_form: [registration_questions: [:registration_options]])
                  .find_by!(internal_name: params[:event_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_registrant_params
    params.require(:registrant).permit(:email,
      serialized_answers: [:question_text, :question_id, :value, value: []])
  end
end
