# frozen_string_literal: true

RSpec.describe RegistrationForm, type: :model do
  context ".destroy" do
    let!(:form) { FactoryBot.create :registration_form }
    let!(:event) { FactoryBot.create :event, registration_form: form }

    it "should not delete if in use" do
      expect(form.destroy).to eq false
    end

    it "should delete if not in use" do
      event.destroy
      expect(form.destroy).not_to eq false
    end
  end

end
