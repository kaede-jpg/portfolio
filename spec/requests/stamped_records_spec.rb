require 'rails_helper'

RSpec.describe "StampedRecords", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/stamped_records/create"
      expect(response).to have_http_status(:success)
    end
  end

end
