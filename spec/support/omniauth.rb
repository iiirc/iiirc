def auth_params_for(user)
  {
    "uid"      => user["uid"],
    "provider" => user["provider"],
    "info"     => {
      "nickname" => user["username"],
      "email"    => user["email"]
    }
  }
end

def sign_in(user)
  OmniAuth.config.mock_auth[:github] = auth_params_for(user)
  visit signin_path
end
