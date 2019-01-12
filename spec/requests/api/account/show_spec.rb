# frozen_string_literal: true

describe "Account APIs", type: :request  do
  describe "Get #show" do
    context "when is successfully created" do
      before(:each) do
        @user = FactoryBot.create :user_with_team
        api_authorization_header(@user.login_with_token!)
      end

      it "render user json" do
        get api_base_url + "/account/current", params: {}, headers: request_headers

        response = json_response[:data]
        expect(json_response[:code]).to eql RESPONSE_CODE[:success]

        expect(response[:id]).to eql @user.id
        expect(response[:name]).to eql @user.name
        expect(response[:first_name]).to eql @user.first_name
      end
    end
  end
end
