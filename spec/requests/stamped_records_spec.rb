require 'rails_helper'

RSpec.describe 'StampedRecords', type: :request do
  let(:record) { create(:record) }
  let(:stamp) { create(:stamp) }
  let(:user) { create(:user) }

  before do
    disable_csrf_protection
    request_login_as(user)
  end

  describe 'GET /create' do
    it 'creates a new Comment' do
      expect do
        post record_stamped_records_path(record, stamp_id: stamp.id), xhr: true
      end.to change(StampedRecord, :count).by(1)
    end

    it 'returns http success' do
      post record_stamped_records_path(record, stamp_id: stamp.id), xhr: true
      expect(response).to have_http_status(:success)
    end
  end
end
