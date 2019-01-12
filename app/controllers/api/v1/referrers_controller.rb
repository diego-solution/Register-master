# frozen_string_literal: true

# API for creating new referrers for events
class Api::V1::ReferrersController < ApiController
  before_action :set_event, only: [:create]

  def create
    @ref = @event.referrers.where(email: referrer_params[:email]).first

    update && return if @ref

    @ref = @event.referrers.build(referrer_params)

    if @ref.save
      render_success({ success: true }, message: "The link was sent to the email.")
    else
      render_error(RESPONSE_CODE[:unprocessable_entity], @ref.errors.full_messages.join(","), @ref.errors)
    end
  end

  def update
    if @ref.update(referrer_params)
      render_success({ success: true }, message: "Sent referral link to email")
    else
      render_error(RESPONSE_CODE[:unprocessable_entity], @ref.errors.full_messages.join(","), @ref.errors)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id] || params[:event_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def referrer_params
    params.require(:referrer).permit(:event_id, :name, :email)
  end
end
