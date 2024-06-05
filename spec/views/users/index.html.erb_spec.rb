require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    assign(:users, [
             User.create!(
               user_id: 'user_1',
               name: 'MyString',
               email: 'Email1',
               password: 'MyString',
               password_confirmation: 'MyString'
             ),
             User.create!(
               user_id: 'user_2',
               name: 'MyString',
               email: 'Email2',
               password: 'MyString',
               password_confirmation: 'MyString'
             )
           ])
  end

  it 'renders a list of users' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Email'.to_s), count: 2
  end
end
