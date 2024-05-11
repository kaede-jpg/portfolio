require 'rails_helper'

=begin
RSpec.describe 'Oauths', type: :request do
  describe 'GET /:provider' do
    it 'returns http success' do
      get '/oauths/:provider'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /callback' do
    it 'returns http success' do
      get '/oauths/callback'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /callback' do
    it 'returns http success' do
      post '/oauths/callback'
      expect(response).to have_http_status(:success)
    end
  end
end
=end