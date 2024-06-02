require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/comment/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/comment/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/comment/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
