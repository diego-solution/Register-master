# frozen_string_literal: true

RSpec.describe Registrant, type: :model do
  context "when created" do
    let!(:event) { FactoryBot.create :event }
    let(:registrant) { FactoryBot.build :registrant, event: event, team: event.team }

    it "is expected to send register email" do
      expect(registrant.save!).to be true
      expect(registrant.registered?).to be true
      expect(ActionMailer::Base.deliveries.last.subject)
        .to eq I18n.t("mailers.notifications_mailer.register.subject")
    end

    it "is expected to grab email from answers" do
      expect(registrant.save!).to be true
      expect(registrant.email).to eq "niko@tasboa.com"
    end

    it "is expected to grab email from answers with weird question names" do
      registrant.serialized_answers = [{"question_text": "o primeiro nome", "question_id": registrant.event.registration_form.registration_questions.first.id, "value": "Pedro"}, 
                                       {"question_text": "zee email", "question_id": registrant.event.registration_form.registration_questions.last.id, "value": "psousa@thinkorange.pt"}]
      expect(registrant.save!).to be true
      expect(registrant.email).to eq "psousa@thinkorange.pt"
    end

    it "is expected to grab email from answers with weird question names 2" do
      registrant.serialized_answers = [{"question_text": "First Name", "question_id": 1, "value": "Pedro"}, 
                                       {"question_text": "zee Email meine", "question_id": 2, "value": "psousa@thinkorange.pt"}]
      expect(registrant.save!).to be true
      expect(registrant.email).to eq "psousa@thinkorange.pt"
    end

    it "is expected to grab email from questions if doesnt find in answer" do
      registrant.serialized_answers = [{"question_text": "o primeiro nome", "question_id": registrant.event.registration_form.registration_questions.first.id, "value": "Pedro"}, 
                                       {"question_text": "zee email", "question_id": registrant.event.registration_form.registration_questions.last.id, "value": "psousa@thinkorange.pt"}]
      expect(registrant.save!).to be true
      expect(registrant.email).to eq "psousa@thinkorange.pt"
    end

    it "is expected not to duplicate another entry with same email" do
      FactoryBot.create(:registrant, event: registrant.event)
      expect(registrant.save).to be false
      expect(registrant.email).to eq "niko@tasboa.com"
    end

    it "is expected to encrypt information" do
      expect(registrant.save!).to be true
      expect(registrant.email_hash).to eq Digest::MD5.hexdigest("niko@tasboa.com")
      expect(registrant.encrypted_email).not_to eq nil
      expect(registrant.encrypted_serialized_answers).not_to eq nil
    end
  end

  context "when confirmed" do
    let(:registrant) { FactoryBot.create :registrant }

    it "is expected to send email" do
      expect(registrant.confirm_registration("confirm")).to be true
      expect(registrant.confirmed?).to be true
      registrant.save

      expect(ActionMailer::Base.deliveries.last.subject)
        .to eq I18n.t("mailers.notifications_mailer.confirm.subject")
    end

    it "is expected to abort if event is full" do
      registrant.event.update(capacity: 0)
      expect(registrant.confirm_registration("confirm")).to be false
      expect(registrant.confirmed?).to be false
    end
  end

  context "when canceled" do
    let(:registrant) { FactoryBot.create :registrant }

    it "is expected to send email" do
      expect(registrant.cancel!).to be true
      expect(registrant.canceled?).to be true
      expect(ActionMailer::Base.deliveries.last.subject)
        .to eq I18n.t("mailers.notifications_mailer.cancel.subject")
    end

    it "is expected not to allow from confirmed" do
      skip "allowing this for now"
      expect(registrant.confirm!).to be true
      expect(registrant.cancel!).to be false
      expect(ActionMailer::Base.deliveries.last.subject)
        .to eq I18n.t("mailers.notifications_mailer.confirm.subject")
    end
  end
end
