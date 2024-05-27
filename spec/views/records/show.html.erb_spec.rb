require 'rails_helper'

RSpec.describe "records/show", type: :view do
  before(:each) do
    assign(:record, Record.create!(
      user_id: 2,
      meal_image: "Meal Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Meal Image/)
  end
end
