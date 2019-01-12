# frozen_string_literal: true

RSpec.describe User, type: :model do
  
  context ".generate_welcome_email" do
    let!(:user) { FactoryBot.create :user_with_team }

    # it "should create a default group" do
    #   expect(team.groups.size).to eq 1
    #   expect(team.groups.first.name).to eq I18n.t("defaults.group_name")
    # end

    it "is expected to send welcome email" do
      expect(user.generate_welcome_email).to be true
      expect(ActionMailer::Base.deliveries.last.subject)
        .to eq I18n.t("mailers.informations_mailer.welcome_user.subject", name: user.team_memberships.first.team.name)
    end

  end

  # def can_switch_team(team_id)
  #   if super_admin
  #     team_id = Team.find params[:team_id]
  #     admin   = true
  #   else
  #     membership = team_memberships.find_by!(team_id: params[:team_id])
  #     team_id = membership.team_id
  #     admin   = membership.admin
  #   end
  #   {team_id: team_id, admin: admin}
  # end

  context ".can_switch_team" do
    let!(:user) { FactoryBot.create :user_with_team }
    let(:team) { FactoryBot.create :team_orange }

    it "should return team and admin if super admin" do
      user.super_admin = true
      terms = user.can_switch_team(team.id)

      expect(terms[:team_id]).to eq team.id
      expect(terms[:admin]).to eq true
    end

    it "should return permissions for team membership" do
      team.users << user
      terms = user.can_switch_team(team.id)

      expect(terms[:team_id]).to eq team.id
      expect(terms[:admin]).to eq false
    end

    it "is expected to blow up if no team exists and is not super admin" do
      expect { user.can_switch_team(213213) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context ".login_with_token!" do
    let!(:user) { FactoryBot.create :user_with_team }
    let(:team) { FactoryBot.create :team_orange }

    it "is expected to fill default team and admin if no params given" do
      token = user.login_with_token!
      untoken = JsonWebToken.decode(token).first

      expect(untoken["team"]).to eq user.team_memberships.first.team_id
      expect(untoken["admin"]).to eq user.team_memberships.first.admin
    end

    it "is expected to switch to another team and permissions" do
      team.users << user
      token   = user.login_with_token!(team.id, false )
      untoken = JsonWebToken.decode(token).first

      expect(untoken["team"]).to eq team.id
      expect(untoken["admin"]).to eq false
    end

    it "is expected to set admin true if super_admin and no params" do
      user.super_admin = true
      token   = user.login_with_token!
      untoken = JsonWebToken.decode(token).first

      expect(untoken["team"]).to eq user.teams.first.id
      expect(untoken["admin"]).to eq true
    end

  end
end
