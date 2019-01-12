# frozen_string_literal: true

require "rails_helper"

RSpec.describe Referrer, type: :model do
  context "when creating" do
    let(:referrer) { FactoryBot.build :referrer }

    it "is should generate a link" do
      expect(referrer.save).to eq true
      expect(referrer.link).to include(referrer.token)
    end

    # it "is should require a event" do
    #   referrer.event = nil
    #   expect(referrer.save).to eq false
    # end

    it "is should require a name" do
      referrer.name = nil
      expect(referrer.save).to eq false
    end

    it "should send a email with url" do
      expect(ActionMailer::Base.deliveries.last.subject).to eq I18n.t("mailers.informations_mailer.referrer_link.subject", name: referrer.event.public_name)
    end
  end
end
