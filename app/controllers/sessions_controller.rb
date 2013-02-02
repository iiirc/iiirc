class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid])

    if user
      session[:user_id] = user.id
      redirect_to root_path notice: "Signed up!"
    else
      store_auth_params(auth)
      redirect_to signup_path :notice => "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Signed out!"
  end

  private

  def store_auth_params(auth)
    paramz = auth.slice(:provider, :uid)
    paramz[:info] = auth[:info].symbolize_keys.slice(:email, :nickname) # nickname is like -> "banyan"
    session[:params_from_authenticator] = paramz
  end
end
