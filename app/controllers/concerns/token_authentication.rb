# frozen_string_literal: true

# handles authentication using jwt token instead of devise
module TokenAuthentication
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  protected

  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    unless JsonWebToken.valid_payload(payload.first)
      logger.debug("###token is not valid")
      return invalid_authentication
    end
    load_current_user!
    #save_last_seen_at
    invalid_authentication unless @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    # render json: {error: "Invalid Request"}, status: :unauthorized
    render_error(RESPONSE_CODE[:unauthorized], "Your session has expired. Please login again.", "")
  end

  private

  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    token = request.headers.fetch("Authorization", "").split(" ").last
    # logger.debug("fetching payload, token is #{token}")
    response = JsonWebToken.decode(token)
    # logger.debug("response is #{response}")
    response
  end

  # Sets the @current_user with the user_id from payload
  def load_current_user!
    @current_user = User.find_by(id: payload[0]["sub"])
  end

  def save_last_seen_at
    @current_user.update_attributes(sign_in_count: @current_user.sign_in_count + 1,
                                    current_sign_in_at: Time.current)
  end
end
