require 'rails_helper'

RSpec.describe 'records/index', type: :view do
  let(:user) { create(:user) }
  before(:each) do
    allow(view).to receive(:current_user).and_return(user)
    allow(user).to receive(:monitored?).and_return(true) 
    assign(:records, [
             @record = create(:record),
             create(:record)
           ])
    @comment = assign(:comment, create(:comment))
  end

  it 'renders a list of records' do
    render
    assert_select 'h2', text: Regexp.new(@record.created_at.strftime("%H：%M").to_s), count: 2
#   assert_select 'img[src=?]', 'spec/fixtures/test_image.png', count: 2
  end
end
