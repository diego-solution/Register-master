# frozen_string_literal: true

FactoryBot.define do
  factory :event, class: "Event" do
    public_name "My little Event"

    association :team, factory: :team_orange
    association :group, factory: :group1
    association :language, factory: :language
    association :registration_form, factory: :registration_form
 
    city "Lisbon"
    country "Portugal"
    registration_start_date Time.zone.now + 1.day
    registration_close_date Time.zone.now + 3.days
    event_start_date Time.zone.now + 5.days
    event_end_date Time.zone.now + 6.days
    time_zone "Europe/Moscow"
    capacity 20
    location  "LX Factory"
    at_capacity_action "stop"
    status :published

    # after(:create) do |event, evaluator|
    #   create_list(:default_page_content, 1, event: event, team: event.team)
    # end
  end

  factory :event_blank, class: "Event" do
    public_name "Oranges Big Event"

    association :team, factory: :team_orange
    association :group, factory: :group1
    association :language, factory: :language

    city "Porto"
    country "Portugal"
    registration_start_date Time.zone.now + 1.day
    registration_close_date Time.zone.now + 3.days
    event_start_date Time.zone.now + 4.days
    event_end_date Time.zone.now + 10.days
    time_zone "Europe/Lisbon"
    capacity 2
    location  "LX Factory"
    at_capacity_action "stop"
    status :draft
    description "Some text to include"
    from_name "Dude"
    from_address "cenas@eventacc.es"
  end
end
