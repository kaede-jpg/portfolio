module LoginMacros
    def feature_login_as(user)
        visit root_path
        click_link 'ログイン'
        fill_in 'User', with: user.user_id
        fill_in 'Password', with: 'password'
        click_button 'Login'
    end

    def request_login_as(user)
        post '/login', params: { user_id: user.user_id, password: 'password' }
    end
end