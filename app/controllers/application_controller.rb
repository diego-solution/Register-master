# frozen_string_literal: true

# general application controller
class ApplicationController < ActionController::Base
  include ApplicationHelper
  #protect_from_forgery with: :exception
  #skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }
  protect_from_forgery prepend: true

  
  # authenticates current user in activeadmin
  def authenticate_admin_user!
    authenticate_user!
    unless current_user.super_admin
      flash[:error] = "This area is restricted. Sorry."
      
      if current_user
        sign_out current_user
      end

      redirect_to new_session_path()
    end
  end

  # returns current user in activeadmin
  def current_admin_user
    return nil if user_signed_in? && ! current_user.super_admin
    current_user
  end

end
