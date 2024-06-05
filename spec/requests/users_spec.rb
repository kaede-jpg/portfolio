require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/users', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      user_id: 'user_id',
      name: 'name',
      email: 'email@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:invalid_attributes) do
    {
      user_id: 'user_id',
      name: '',
      email: '',
      password: 'p',
      password_confirmation: 'mismatch'
    }
  end

  before do
    disable_csrf_protection
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:user)
      get users_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = create(:user)
      request_login_as(user)
      get user_path(user)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      user = create(:user)
      request_login_as(user)
      get edit_user_path(user)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post users_path, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to users' do
        post users_path, params: { user: valid_attributes }
        expect(response).to redirect_to(users_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post users_path, params: { user: invalid_attributes }
        end.to change(User, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post users_path, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          user_id: 'user_id_2',
          name: 'name_2',
          email: 'email2@example.com',
          password: 'password2',
          password_confirmation: 'password2'
        }
      end
      let(:user) { create(:user) }
      before do
        request_login_as(user)
      end

      it 'updates the requested user' do
        patch user_path(user), params: { user: new_attributes }
        user.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to users' do
        patch user_path(user), params: { user: new_attributes }
        user.reload
        expect(response).to redirect_to(users_path)
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        user = create(:user)
        request_login_as(user)
        patch user_path(user), params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:user) { create(:user) }
    before do
      request_login_as(user)
    end
    it 'destroys the requested user' do
      expect do
        delete user_path(user)
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete user_path(user)
      expect(response).to redirect_to(users_path)
    end
  end
end
