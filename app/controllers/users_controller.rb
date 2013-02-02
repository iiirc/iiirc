# coding: utf-8

class UsersController < ApplicationController
  verify session: :params_from_authenticator, only: %w(new create), redirect_to: :login_path

  def new
    @user = User.new_with_omniauth(session[:params_from_authenticator])
    client = Octokit::Client.new(login: @user.username, oauth_token: @user.token)
    organizations = client.organizations(@user.username)
    @organizations = organizations.map do |organization|
      Organization.find_or_create_by_login_and_original_id(organization.login, organization.id)
    end
  end

  def create
    @user = User.new_with_omniauth(session[:params_from_authenticator])
    # TODO ここでは厳密にこのユーザが本当に Organization に紐づいているかの検証を GitHub 側に確認する必要がある
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
