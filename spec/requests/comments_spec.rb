require 'rails_helper'

RSpec.describe 'Comments', type: :request do

  let(:record) { create(:record) }
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
      body: "body"
    }
  end

  let(:invalid_attributes) do
    {
      body: ""
    }
  end

  before do
    disable_csrf_protection
    request_login_as(user)
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Comment' do
        expect do
          post record_comments_path(record), params: { comment: valid_attributes }, xhr: true
        end.to change(Comment, :count).by(1)
      end

      it 'returns http success' do
        post record_comments_path(record), params: { comment: valid_attributes }, xhr: true
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Comment' do
        expect do
          post record_comments_path(record), params: { comment: invalid_attributes }, xhr: true
        end.to change(Comment, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post record_comments_path(record), params: { comment: invalid_attributes }, xhr: true
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:comment) { create(:comment, user_id: user.id) }
    it 'destroys the requested comment' do
      expect do
        delete comment_path(comment), xhr: true
      end.to change(Comment, :count).by(-1)
    end

    it 'returns http success' do
      delete comment_path(comment), xhr: true
      expect(response).to have_http_status(:success)
    end
  end
end
