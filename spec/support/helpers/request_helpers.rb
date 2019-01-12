# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json_response
      @json ||= JSON.parse(response.body, symbolize_names: true)
      #puts @json
      @json
    end
  end

  # Our headers helpers module
  module HeadersHelpers
    def request_headers
      @headers ||= {}
    end

    def api_base_url
      "/api/#{api_version}"
    end

    def api_version
      "v1"
    end

    def api_header(_version = 1)
      request_headers["Accept-Version"] = api_version
    end

    def api_response_format
      request_headers["Content-Type"] = "application/json"
    end

    def include_default_accept_headers
      # pedro: we're not putting the version in the header but we could
      #api_header
      api_response_format
    end

    # Add auth token to Authorization in header
    def api_authorization_header(token)
      #puts "adding Token = #{token}"
      request_headers["Authorization"] = token
    end
  end
end
