# frozen_string_literal: true

FactoryBot.define do
  factory :team, class: "Team" do
    name "Team Eventfuel"
    before(:create) do |order, evaluator|
      FactoryBot.create :default_layout
    end
  end
  factory :team_orange, class: "Team" do
    name "Team Orange"
  end
end
