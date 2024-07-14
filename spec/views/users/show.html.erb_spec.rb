require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before(:each) do
    assign(:user, User.create!(
                    name: 'MyString',
                    email: 'Email',
                    password: 'MyString',
                    password_confirmation: 'MyString',
                    agreement: true
                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Email/)
  end
end
