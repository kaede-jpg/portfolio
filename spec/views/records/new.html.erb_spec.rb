require 'rails_helper'

RSpec.describe 'records/new', type: :view do
  before(:each) do
    assign(:record, Record.new(
                      user_id: 1,
                      meal_image: fixture_file_upload('spec/fixtures/test_image.png')
                    ))
  end

  it 'renders new record form' do
    render

    assert_select 'form[action=?][method=?]', records_path, 'post' do
      assert_select 'input[name=?]', 'record[meal_image]'
    end
  end
end
