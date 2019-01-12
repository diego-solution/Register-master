# frozen_string_literal: true

FactoryBot.define do
  factory :referrer, class: "Referrer" do
    email "niko@tasboa.com"
    name "Niko Roberts"
    association :event, factory: :event
  end
end
