require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  let(:user) do
    User.create!(
      name: 'MyString',
      email: 'MyString',
      password: 'MyString',
      password_confirmation: 'MyString',
      agreement: true
    )
  end

  before(:each) do
    assign(:user, user)
  end

  it 'renders the edit user form' do
    render

    assert_select 'form[action=?][method=?]', user_path, 'post' do
      assert_select 'input[name=?]', 'user[email]'
    end
  end
end
