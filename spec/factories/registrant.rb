# frozen_string_literal: true

answer = [{"question_text": "First Name", "question_id": 1, "value": "Pedro"}, {"question_text": "E-mail", "question_id": 2, "value": "niko@tasboa.com"}]

FactoryBot.define do
  factory :registrant, class: "Registrant" do
    association :team, factory: :team
    association :event, factory: :event

    #TODO: add answers
    #TODO add status
    serialized_answers answer
  end
end
