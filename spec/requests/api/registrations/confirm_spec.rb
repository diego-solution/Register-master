# frozen_string_literal: true

describe "Registrant API", type: :request  do
  describe "PUT #confirm" do
    context "when confirming or canceling" do
      before(:each) do
        # FactoryBot.create :language
        @event = FactoryBot.create :event, status: :published
        @registrant = FactoryBot.create :registrant, event: @event
      end

      it "confirms the presence of a registrant" do
        put api_base_url + "/events/#{@registrant.event.internal_name}/registrants/#{@registrant.token}/confirm", 
            params: { option: "confirm" }.to_json,
            headers: request_headers

        response = json_response[:data]
        expect(json_response[:code]).to eql RESPONSE_CODE[:success]

        expect(response[:id]).to eql @registrant.id
        expect(response[:registration_status]).to eql "confirmed"
      end

      it "cancels the presence of a registrant" do
        put api_base_url + "/events/#{@registrant.event.internal_name}/registrants/#{@registrant.token}/confirm", params: { option: "cancel" }.to_json, headers: request_headers

        response = json_response[:data]
        expect(json_response[:code]).to eql RESPONSE_CODE[:success]

        expect(response[:id]).to eql @registrant.id
        expect(response[:registration_status]).to eql "canceled"
      end
    end

    context "when error" do
      before(:each) do
        @event = FactoryBot.create :event, status: :published
        @registrant = FactoryBot.create :registrant, event: @event
      end

      after do
        expect(json_response[:code]).not_to eql RESPONSE_CODE[:success]
      end

      it "render error when not found" do
        put api_base_url + "/events/#{@registrant.event_id}/registrants/coco/confirm", params: { action: "confirm" }.to_json, headers: request_headers

        json_data = json_response[:data]
        expect(json_data.blank?).to eql true
        expect(json_response[:code]).to eql RESPONSE_CODE[:not_found]
      end
    end
  end
end
