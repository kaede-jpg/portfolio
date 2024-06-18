require 'rails_helper'

RSpec.describe 'PasswordResets', type: :request do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
      email: user.email
    }
  end

  before do
    disable_csrf_protection
    request_login_as(user)
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_password_reset_path
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'redirects to records' do
        post password_resets_path, params: { user: valid_attributes }
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
