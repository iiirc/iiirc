def auth_params_for(user)
  {
    uid:  user[:uid],
    provider: user[:provider],
    info: {
      nickname: user[:username],
      email: user[:email]
    },
    credentials: {
      token: user[:token]
    }
  }
end

def sign_in(user)
  OmniAuth.config.mock_auth[:github] = auth_params_for(user)
  visit signin_path
end

def sign_out
  visit root_path
  click_on('Sign out')
end
