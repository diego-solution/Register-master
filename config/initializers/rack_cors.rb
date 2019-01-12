# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch("DOMAIN") { "eventacc.es" }

    resource "*",
             headers: :any,
             credentials: true,
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
