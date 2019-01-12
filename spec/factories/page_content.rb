# frozen_string_literal: true

# page content
FactoryBot.define do
  factory :default_page_content, class: "PageContent" do
    name "Default Template"
    association :page_layout, factory: :default_layout
    association :team, factory: :team_orange
    association :event, factory: :event

    disable_sidebar false
    header "<h1>{{event.name}}</h1><h2>{{event.city}}</h2>"
    sidebar "{{event.start_date}} at {{event.start_time}}"
    body "Go to {{event.location}}"
    footer "2018 All rights reserved"
  end
end
