# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe "Instructions for registrant" do
    let(:user) { FactoryBot.create :registrant }
    let(:mail) { NotificationsMailer.register(user) }

    it "renders the receiver email" do
      expect(mail.from).to eql([ENV["SENDER_EMAIL"]])
    end

    it "renders the sender email" do
      expect(mail.to).to eql([user.email])
    end

    it "assigns some text" do
      expect(mail.body.encoded).to match(user.event.public_name)
    end
  end

  describe "Cancel instructions for registrant" do
    let(:user) { FactoryBot.create :registrant, email: "u@o.pt" }
    let(:mail) { NotificationsMailer.cancel(user) }

    it "renders the receiver email" do
      expect(mail.from).to eql([ENV["SENDER_EMAIL"]])
    end

    it "renders the sender email" do
      expect(mail.to).to eql([user.email])
    end

    it "assigns some text" do
      expect(mail.body.encoded).to match(user.event.public_name)
    end
  end

  describe "Confirm instructions for registrant" do
    let(:user) { FactoryBot.create :registrant, email: "u@o.pt" }
    let(:mail) { NotificationsMailer.confirm(user) }

    it "renders the receiver email" do
      expect(mail.from).to eql([ENV["SENDER_EMAIL"]])
    end

    it "renders the sender email" do
      expect(mail.to).to eql([user.email])
    end

    it "assigns some text" do
      expect(mail.body.encoded).to match(user.event.public_name)
    end
  end
end
