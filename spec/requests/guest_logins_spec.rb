require 'rails_helper'

RSpec.describe 'GuestLogins', type: :request do
  before do
    disable_csrf_protection
  end
  describe 'POST /create' do
    it 'creates a new User' do
      expect do
        post guest_login_path
      end.to change(User, :count).by(1)
    end
    it 'returns http success' do
      post guest_login_path
      expect(response).to have_http_status(:found)
    end
  end

  describe 'POST /guest/change_role' do
    it 'returns http success' do
      post guest_change_role_path
      expect(response).to have_http_status(:found)
    end
  end
end
