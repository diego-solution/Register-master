# frozen_string_literal: true

FactoryBot.define do
  factory :registration_form, class: "RegistrationForm" do
    name "Basic Information"
    archived false
    association :team, factory: :team

    after(:create) do |this_survey|
      create(:question_single, registration_form: this_survey)
      create(:question_email, registration_form: this_survey)
    end
  end
end
