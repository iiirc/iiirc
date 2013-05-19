# coding: utf-8

class UsersController < ApplicationController
  verify session: :params_from_authenticator, only: %w(new create), redirect_to: :login_path

  # GET /users/iiirc
  def show
    @user = User.find_by_username(params[:id])

    if @user
      snippets = @user.snippets.date_desc.page(params[:page])
      snippets = snippets.published unless @user.id == current_user.try(:id)
      @snippets = snippets.decorate
    else
      return render_not_found
    end
  end

  # GET /users
  def new
    @user = User.new_with_omniauth(session[:params_from_authenticator])
    @organizations = @user.find_or_create_organizations
  end

  # POST /users
  def create
    @user = User.new_with_omniauth(session[:params_from_authenticator])
    @organizations = @user.find_or_create_organizations

    # TODO ここでは厳密にこのユーザが本当に Organization に紐づいているかの検証を GitHub 側に確認する必要がある
    @user.attributes = params[:user]

    if @user.save
      session[:user_id] = @user.id
      session.delete(:params_from_authenticator)
      redirect_to root_url, notice: "Signed up!"
    else
      render :new
    end
  end
end
