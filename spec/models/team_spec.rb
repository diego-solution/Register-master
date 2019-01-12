# frozen_string_literal: true

RSpec.describe Team, type: :model do
  context ".create" do
    let(:team) { FactoryBot.create :team }

    it "should create a default group" do
      expect(team.groups.size).to eq 1
      expect(team.groups.first.name).to eq I18n.t("defaults.group_name")
    end

    it "should create a default form" do
      expect(team.registration_forms.size).to eq 1
    end

    it "should create a duplicate for the layouts" do
      expect(team.page_layouts.size).to eq 1
      expect(PageLayout.all.size).to eq 2
      expect(PageLayout.templates.size).to eq 2
      expect(PageLayout.templates.where(team_id: nil).size).to eq 1
    end
  end
end
