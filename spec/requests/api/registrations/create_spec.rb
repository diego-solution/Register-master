# frozen_string_literal: true
answer = [{"question_text": "First Name", "question_id": 1, "value": "Pedro"}, {"question_text": "E-mail", "question_id": 2, "value": "niko@tasboa.com"}]

describe "Registration APIs", type: :request  do
  
  describe "POST #create" do
    before(:each) do
      @event = FactoryBot.create :event, status: :published
    end

    context "when is successfully created" do
      it "render registrant json" do

        post api_base_url + "/events/#{@event.internal_name}/registrants",
             params: { registrant: { serialized_answers: answer } }.to_json,
             headers: request_headers

        response_body = json_response[:data]
        expect(response_body[:email]).to eql "niko@tasboa.com"
        expect(response_body[:registration_status]).to eql "registered"
      end

      it "render registrant and referrer json" do
        referrer = FactoryBot.create(:referrer, event: @event)

        post api_base_url + "/events/#{@event.internal_name}/registrants/",
             params: { token: referrer.token, registrant: { serialized_answers: answer } }.to_json,
             headers: request_headers

        response_body = json_response[:data]
        expect(response_body[:email]).to eql "niko@tasboa.com"
        expect(response_body[:registration_status]).to eql "registered"
        expect(response_body[:referrer_name]).to eql "Niko Roberts  (niko@tasboa.com)"
      end
    end

    context "when has error" do
      it "renders error when event is full" do
        @event.update_attributes(capacity: 1 )
        FactoryBot.create(:registrant, event: @event).confirm!

        post api_base_url + "/events/#{@event.internal_name}/registrants",
             params: { registrant: { email: "dude@think.pt" } }.to_json,
             headers: request_headers

        response_body = json_response
        expect(response_body[:code]).to eql RESPONSE_CODE[:unprocessable_entity]
        expect(response_body[:message]).to eql "Registration is full for this event"
      end
      
      it "does not render error when event is full but on waitlist" do
        @event.update_attributes(capacity: 1, at_capacity_action: "waitlist")
        FactoryBot.create(:registrant, event: @event).confirm!

        post api_base_url + "/events/#{@event.internal_name}/registrants",
             params: { registrant: { email: "dude@think.pt" } }.to_json,
             headers: request_headers

        response_body = json_response
        expect(response_body[:code]).to eql RESPONSE_CODE[:success]
      end
       
      it "renders error when event is over" do
        @event.finish!

        post api_base_url + "/events/#{@event.internal_name}/registrants",
             params: { registrant: { email: "dude@think.pt" } }.to_json,
             headers: request_headers

        response_body = json_response
        expect(response_body[:code]).to eql RESPONSE_CODE[:unprocessable_entity]
        expect(response_body[:message]).to eql "Registration is over for this event"
      end

      it "render error when missing event" do
        post api_base_url + "/events/#{@event.id}/registrants",
             params: { registrant: { email: "dude@think.pt" } }.to_json,
             headers: request_headers
        response_body = json_response
        expect(response_body[:code]).to eql RESPONSE_CODE[:not_found]
      end
    end
  end
end
