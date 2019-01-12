# frozen_string_literal: true

FactoryBot.define do
  factory :team_member, class: "TeamMembership" do
    association :team, factory: :user, strategy: :build
    association :user, factory: :user, strategy: :build
    admin false

    trait :admin do
      admin true
    end
  end
end
