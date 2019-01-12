# frozen_string_literal: true

# this mailer contains useful emails for event managers
class InformationsMailer < ApplicationMailer
  default from: ENV["SENDER_EMAIL"]

  # sends a referer link for an event
  def referrer_link(referrer)
    @topic  = referrer.event.public_name
    @when   = referrer.event.when
    @where  = referrer.event.location
    @link   = referrer.link
    @from   = referrer.event.from_name_email || ENV["SENDER_EMAIL"]

    I18n.with_locale(referrer.event.language.key) do
      Time.use_zone(referrer.event.time_zone) do
        mail to: referrer.email, from: @from,
             subject: I18n.t("mailers.informations_mailer.referrer_link.subject", name: @topic)
      end
    end
  end

  # sends password for new team event users
  def welcome_user(name, email, password, team_name)
    @name       = name
    @password   = password
    @team_name  = team_name

    mail to: email,
         subject: I18n.t("mailers.informations_mailer.welcome_user.subject", name: team_name)
  end
end
