# frozen_string_literal: true

# the base api class, all other api classes depend on this
class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  include Response
  include ExceptionHandler
  include TokenAuthentication
  include CurrentContext
  # include JsonApiResponders

  before_action :set_default_format
  before_action :authenticate_request!

  private

  def set_default_format
    request.format = :json
  end
end
