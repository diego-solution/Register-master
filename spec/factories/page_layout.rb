# frozen_string_literal: true

FactoryBot.define do
  factory :default_layout, class: "PageLayout" do
    name "Default Template"
    is_original true
    header "<h1>{{event.name}}</h1><h2>{{event.city}}</h2>"
    sidebar "{{event.start_date}} at {{event.start_time}}"
    body "Go to {{event.location}}"
    footer "{{team.name}} 2018 All rights reserved"
  end
end
