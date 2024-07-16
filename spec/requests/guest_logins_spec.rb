require 'rails_helper'

RSpec.describe 'GuestLogins', type: :request do
  describe 'GET /create' do
    it 'creates a new User' do
      expect do
        get '/guest_login'
      end.to change(User, :count).by(1)
    end
    it 'returns http success' do
      get '/guest_login'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /change_role' do
    it 'returns http success' do
      get '/guest/change_role'
      expect(response).to have_http_status(:found)
    end
  end
end
