# frozen_string_literal: true

describe "Session APIs", type: :request  do
  describe "POST #create" do
    before(:each) do
      @user = FactoryBot.create :user_with_team
    end

    context "when is successfully created" do
      it "render user json" do
        post api_base_url + "/authentication", params: { email: @user.email, password: "please123" }.to_json, headers: request_headers

        json_user = json_response[:data]

        expect(json_user[:token]).not_to eql nil
        # expect(json_user[:uid]).to eql @user.id
        # expect(json_user[:email]).to eql @user.email
        expect(json_response[:code]).to eql RESPONSE_CODE[:success]
      end
    end

    context "when has error" do
      it "render unauthorized error when email and password doesn't match" do
        post api_base_url + "/authentication", params: { email: @user.email, password: "please12sss3" }.to_json, headers: request_headers

        json_user = json_response[:data]

        expect(json_user.blank?).to eql true
        expect(response).to have_http_status(RESPONSE_CODE[:unauthorized])

        expect(json_response[:code]).to eql RESPONSE_CODE[:unauthorized]
        expect(json_response[:message]).to include I18n.t("api.errors.session.invalid")
      end
    end
  end
end
