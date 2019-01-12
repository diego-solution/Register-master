# frozen_string_literal: true

unless Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    address: ENV["MANDRILL_ADDRESS"],
    port: ENV["MANDRILL_PORT"],
    user_name: ENV["MANDRILL_USERNAME"],
    password: ENV["MANDRILL_API_KEY"],
    domain: ENV["MANDRILL_DOMAIN"]
  }
end
# ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = ENV["MANDRILL_API_KEY"]
  config.deliver_later_queue_name = :default
end
