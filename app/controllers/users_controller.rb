class UsersController < ApplicationController
  verify session: :params_from_authenticator, only: %w(new create), redirect_to: :login_path

  def new
    @user = User.new_with_omniauth(session[:params_from_authenticator])
  end

  def create
    @user = User.new_with_omniauth(session[:params_from_authenticator])
    @user.attributes = params[:user]

    if @user.save
      session[:user_id] = @user.id
      session.delete(:params_from_authenticator)
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end
end
