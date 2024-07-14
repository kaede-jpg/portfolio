require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  before(:each) do
    assign(:user, User.new(
                    name: 'MyString',
                    email: 'MyString',
                    password: 'MyString',
                    password_confirmation: 'MyString',
                    agreement: true
                  ))
  end

  it 'renders new user form' do
    render

    assert_select 'form[action=?][method=?]', user_path, 'post' do
      assert_select 'input[name=?]', 'user[email]'
    end
  end
end
