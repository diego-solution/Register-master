# frozen_string_literal: true

require "support/helpers/request_helpers"

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :request
  config.include Requests::HeadersHelpers, type: :request

  config.before(:each, type: :request) do
    include_default_accept_headers
    DatabaseCleaner.clean
  end
end
