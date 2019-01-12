# frozen_string_literal: true

# handles what to return when certain exceptions occur in API
module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from AppException do |e|
      logger.debug(e.error.message)
      render_error(e.http_status, e.error.message, e.error.debug_info)
    end

    # this doesnt work!
    # rescue_from ApplicationController::NotAuthorized do |e|
    #   render_error(RESPONSE_CODE[:unauthorized], e.to_s, "")
    # end
    # rescue_from Pundit::NotAuthorizedError do
    #   respond_with_error(403, 'Not Authorized')
    # end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error RESPONSE_CODE[:not_found], e.message
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error RESPONSE_CODE[:unprocessable_entity], e.message
    end

    # rescue from expired token
    rescue_from JWT::ExpiredSignature do |e|
      render_error(RESPONSE_CODE[:unauthorized], e.to_s, "")
    end

    # rescue from bad token
    rescue_from JWT::DecodeError do |e|
      render_error(RESPONSE_CODE[:unauthorized], e.to_s, "")
    end
  end
end
