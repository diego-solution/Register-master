# frozen_string_literal: true

# mailing registrants
class NotificationsMailer < ApplicationMailer
  default from: ENV["SENDER_EMAIL"]

  def register(registrant)
    @topic    = registrant.event.public_name
    @when     = registrant.event.when
    @where    = registrant.event.location
    @token    = registrant.token
    @event_id = registrant.event.internal_name
    @from     = registrant.event.from_name_email
    @unsub    = I18n.t("mailers.notifications_mailer.unsubscribe")

    I18n.with_locale(registrant.event.language.key) do
      Time.use_zone(registrant.event.time_zone) do
        mail to: registrant.email, 
             from: @from,
             subject: I18n.t("mailers.notifications_mailer.register.subject")
      end
    end
  end

  def cancel(registrant)
    @topic  = registrant.event.public_name
    @when   = registrant.event.when
    @where  = registrant.event.location
    @from   = registrant.event.from_name_email
    @unsub  = I18n.t("mailers.notifications_mailer.unsubscribe")

    I18n.with_locale(registrant.event.language.key) do
      Time.use_zone(registrant.event.time_zone) do
        mail to: registrant.email, from: @from,
             subject: I18n.t("mailers.notifications_mailer.cancel.subject")
      end
    end
  end

  def confirm(registrant)
    @topic  = registrant.event.public_name
    @when   = registrant.event.when
    @where  = registrant.event.location
    @from   = registrant.event.from_name_email
    @unsub  = I18n.t("mailers.notifications_mailer.unsubscribe")

    @ical_url = CalendarService.new(event: registrant.event).share_url("apple")
    @gcal_url = CalendarService.new(event: registrant.event).share_url("google")
    @out_url  = CalendarService.new(event: registrant.event).share_url("outlook")

    I18n.with_locale(registrant.event.language.key) do
      Time.use_zone(registrant.event.time_zone) do
        mail to: registrant.email, from: @from,
             subject: I18n.t("mailers.notifications_mailer.confirm.subject")
      end
    end
  end
end
