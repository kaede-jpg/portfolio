module LoginMacros
  def feature_login_as(user)
    user.activate!
    visit root_path
    click_link 'ログイン'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'ログイン'
  end

  def request_login_as(user)
    user.activate!
    post '/login', params: { email: user.email, password: 'password' }
  end
end
