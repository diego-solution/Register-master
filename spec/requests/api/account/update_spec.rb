# frozen_string_literal: true

describe "Account API", type: :request  do
  describe "PUT #update" do
    context "when saving" do
      before(:each) do
        @user = FactoryBot.create :user_with_team
        api_authorization_header(@user.login_with_token!)
      end

      it "updates name" do
        put api_base_url + "/account/current", params: { first_name: "Dude" }.to_json, headers: request_headers

        response = json_response[:data]
        expect(json_response[:code]).to eql RESPONSE_CODE[:success]

        expect(response[:id]).to eql @user.id
        expect(response[:first_name]).to eql "Dude"
      end

      it "does not update id" do
        put api_base_url + "/account/current", params: { first_name: "Dude", id: 20 }.to_json, headers: request_headers

        response = json_response[:data]
        expect(json_response[:code]).to eql RESPONSE_CODE[:success]

        expect(response[:id]).to eql @user.id
        expect(response[:first_name]).to eql "Dude"
      end

      it "updates password " do
        put api_base_url + "/account/current", params: { password: "teste12345" }.to_json, headers: request_headers

        response = json_response[:data]
        expect(json_response[:code]).to eql RESPONSE_CODE[:success]

        expect(response[:id]).to eql @user.id
      end
    end
  end
end
