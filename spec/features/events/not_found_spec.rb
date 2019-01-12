# frozen_string_literal: true

feature "Opening the event page" do
  scenario "without id should show a event not found", js: true do
    skip "TODO"
    visit "#/ee/asdsad"
    expect(page).to have_content "Event not found"
  end

  scenario "Opening an event with wrong id", js: true do
    skip "TODO"
    visit "#/events/2131asd23"
    expect(page).to have_content "Event not found"
  end
end
