require 'rails_helper'

RSpec.describe "records/index", type: :view do
  before(:each) do
    assign(:records, [
      Record.create!(
        user_id: 2,
        meal_image: "Meal Image"
      ),
      Record.create!(
        user_id: 2,
        meal_image: "Meal Image"
      )
    ])
  end

  it "renders a list of records" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Meal Image".to_s), count: 2
  end
end
