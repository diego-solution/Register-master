# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: "User" do
    first_name "Pedro"
    last_name "Sousa"
    email "psousa@thinkorange.pt"
    password "please123"
    password_confirmation "please123"

    factory :user_with_team do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        teams_count 1
      end
      after(:create) do |profile, evaluator|
        create_list(:team_member, evaluator.teams_count, user: profile, team: FactoryBot.create(:team))
      end
    end
  end
end
