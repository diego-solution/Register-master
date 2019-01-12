# frozen_string_literal: true

# authenticates user in admin via API
class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_request!, only: [:create]

  def create
    user = User.find_by!(email: params[:email])
    #logger.debug("it whaat #{params[:password]}")
    if user.valid_password?(params[:password])
      #logger.debug("it trueee")
      render_success(token: user.login_with_token!)
    else
      render_error RESPONSE_CODE[:unauthorized], I18n.t("api.errors.session.invalid"), ""
    end
  end

  # changes team from dropdown
  def change_team_context
    if params[:team_id].nil?
      render_error RESPONSE_CODE[:unauthorized], I18n.t("api.errors.no_member"), ""
      return
    end

    auth  = current_user.can_switch_team(params[:team_id])
    token = current_user.login_with_token!(auth[:team_id], auth[:admin])
    render_success(token: token)
  end
end
