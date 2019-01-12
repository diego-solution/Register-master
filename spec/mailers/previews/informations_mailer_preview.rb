# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/informations_mailer
class InformationsMailerPreview < ActionMailer::Preview
  def welcome_user
    InformationsMailer.welcome_user("Pedro Sousa", "psousa@thinkorange.pt", "xpto", "Orange")
  end
end
