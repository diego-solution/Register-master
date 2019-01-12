# frozen_string_literal: true

feature "Signing in" do
  background do
    FactoryBot.create(:user, email: "john@thinkorange.pt")
  end

  scenario "Signing in with correct credentials", js: true do
    skip "TODO"
    visit "#/login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "caplin"
    click_button "Sign in"
    expect(page).to have_content "Success"
  end

  given(:other_user) { FactoryBot.create(:user, email: "john@thinkorange.pt") }

  scenario "Signing in as another user" do
    skip "TODO"
    visit "#/login"
    fill_in "Email", with: other_user.email
    fill_in "Password", with: other_user.password
    click_button "Sign in"
    expect(page).to have_content "Invalid email or password"
  end
end
