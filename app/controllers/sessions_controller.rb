class SessionsController < ApplicationController
  # GET /auth/:provider/callback
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid])

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in!"
    else
      store_auth_params(auth)
      redirect_to signup_path
    end
  end

  # DELETE /signout
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully signed out."
  end

  private
  def store_auth_params(auth)
    paramz               = auth.slice(:provider, :uid)
    paramz[:info]        = auth[:info].symbolize_keys.slice(:email, :nickname) # nickname is like -> "banyan"
    paramz[:credentials] = auth[:credentials].symbolize_keys.slice(:token)
    session[:params_from_authenticator] = paramz
  end
end
