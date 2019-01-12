# frozen_string_literal: true

FactoryBot.define do
  factory :group1, class: "Group" do
    name "Portugal"
    association :team, factory: :team
  end
  factory :group2, class: "Group" do
    name "Australia"
    association :team, factory: :team
  end
  factory :group3, class: "Group" do
    name "Portugal"
    association :team, factory: :team, name: "Team Orange"
  end
end
