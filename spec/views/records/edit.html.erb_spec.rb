require 'rails_helper'

RSpec.describe "records/edit", type: :view do
  let(:record) {
    Record.create!(
      user_id: 1,
      meal_image: "MyString"
    )
  }

  before(:each) do
    assign(:record, record)
  end

  it "renders the edit record form" do
    render

    assert_select "form[action=?][method=?]", record_path(record), "post" do

      assert_select "input[name=?]", "record[user_id]"

      assert_select "input[name=?]", "record[meal_image]"
    end
  end
end
