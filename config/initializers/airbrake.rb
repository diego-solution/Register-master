# frozen_string_literal: true

Airbrake.configure do |config|
  # Uncomment for Rails apps
  # config.environment = Rails.env
  # config.ignore_environments = ["development", "test"]
  config.environment = Rails.env
  config.ignore_environments = %w[development test]

  config.host = ENV["AIRBRAKE_HOST"]
  config.project_id = 1
  config.project_key = ENV["AIRBRAKE_PROJECT_KEY"]

  config.app_version = "1"
  config.workers = 2

  Rails.logger = Airbrake::AirbrakeLogger.new(Rails.logger)
end
