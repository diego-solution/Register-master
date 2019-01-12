# frozen_string_literal: true

# general email class
class ApplicationMailer < ActionMailer::Base
  default from: ENV["SENDER_EMAIL"]
  layout "mailer"
end
