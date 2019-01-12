# frozen_string_literal: true

FactoryBot.define do
  factory :question_single, class: RegistrationQuestion do
    required true
    kind "single"
    question "First Name"
    placeholder "Pedro"
  end

  factory :question_email, class: RegistrationQuestion do
    required false
    kind "email"
    help_text "Email"
    question "Email"
  end

  factory :question_multiple, class: RegistrationQuestion do
    required false
    kind "multiple"
    question "Food options"
    after(:create) do |question, _evaluator|
      create(:option_food1, registration_question: question)
      create(:option_food2, registration_question: question)
    end
  end
end