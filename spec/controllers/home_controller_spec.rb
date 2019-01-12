# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController, type: :controller do
  include Devise::Test::ControllerHelpers

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PageContentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end
end
