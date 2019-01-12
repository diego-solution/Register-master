# frozen_string_literal: true

# manages current context/team when using the API
module CurrentContext
  extend ActiveSupport::Concern

  # returns current team for logged in user
  def current_team
    return nil if params[:team_id].nil?
    if current_user.super_admin
      Team.find_by(id: params[:team_id])
    else
      current_user.teams.find_by(id: params[:team_id])
    end
  end

  # returns current user in api
  # this is exactily the same as in jwt devise strategy
  # def current_user
  #   #token   = request.headers.fetch("Authorization", "").split(" ").last
  #   #payload = JsonWebToken.decode(token)
  #   @current_user = current_user #|| @current_user = User.find(payload["sub"])
  # rescue ::JWT::ExpiredSignature
  #   logger.debug "Auth token is expired"
  #   nil
  # rescue ::JWT::DecodeError
  #   logger.debug "Auth token is invalid"
  #   nil
  # end
end
