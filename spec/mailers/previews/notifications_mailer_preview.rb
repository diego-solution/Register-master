# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/notifications_mailer
class NotificationsMailerPreview < ActionMailer::Preview
  def register
    #registrant = FactoryBot.create :registrant, email: 'u@o.pt'
    registrant = Registrant.last
    NotificationsMailer.register(registrant)
  end

  def cancel
    #registrant = FactoryBot.create :registrant, email: 'u@o.pt'
    registrant = Registrant.last
    NotificationsMailer.cancel(registrant)
  end

  def confirm
    #registrant = FactoryBot.create :registrant, email: 'u@o.pt'
    registrant = Registrant.last
    NotificationsMailer.confirm(registrant)
  end
end
