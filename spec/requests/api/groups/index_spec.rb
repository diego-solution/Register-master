# frozen_string_literal: true

describe "Group APIs", type: :request  do
  describe "Get #index" do
    context "when is successfully created" do
      before(:each) do
        @user = FactoryBot.create :user_with_team
        api_authorization_header(@user.login_with_token!)

        @f1 = FactoryBot.create :group1, team: @user.teams.first
        @f2 = FactoryBot.create :group2, team: @user.teams.first
        FactoryBot.create :group3
      end

      it "render user json" do
        get api_base_url + "/groups", params: { team_id: @user.teams.first.id }, headers: request_headers
        response = json_response[:data]
        expect(json_response[:code]).to eql RESPONSE_CODE[:success]

        expect(response.size).to eql 3 # now has default group
        expect(response.first[:id]).to eql @f2.id
        expect(response.first[:name]).to eql @f2.name
      end
    end

    context "when error" do
      after do
        expect(json_response[:code]).not_to eql RESPONSE_CODE[:success]
      end

      it "render unauthorized error when un-authenticated" do
        skip "TODO "
        # get api_base_url + "/groups", params: {}, headers: request_headers
        # json_data = json_response[:data]
        # expect(json_data.blank?).to eql true
        # expect(json_response[:code]).to eql RESPONSE_CODE[:unauthorized]
        # expect(json_response[:message]).to include I18n.t("api.errors.not_authenticated")
      end
    end
  end
end
