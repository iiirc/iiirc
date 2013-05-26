# coding: utf-8

class UsersController < ApplicationController
  before_action :set_user, only: %w(edit update)
  verify session: :params_from_authenticator, only: %w(new create), redirect_to: :root_path, add_flash: { alert: "A unknown error occured.. O_o" }

  # GET /users/iiirc
  def show
    @user = User.find_by_username(params[:id])

    if @user
      snippets = @user.snippets.with_assoc.date_desc.page(params[:page])
      snippets = snippets.published if @user.id != current_user.try(:id) or params[:format] == 'atom'
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

  # GET /settings
  def edit
    @organizations = @user.find_or_create_organizations
  end

  # POST /users
  def create
    @user = User.new_with_omniauth(session[:params_from_authenticator])
    @organizations = @user.find_or_create_organizations

    # TODO ここでは厳密にこのユーザが本当に Organization に紐づいているかの検証を GitHub 側に確認する必要がある
    @user.attributes = user_params if params[:user].present?

    if @user.save
      session[:user_id] = @user.id
      session.delete(:params_from_authenticator)
      redirect_to root_url, notice: "Signed up!"
    else
      render :new
    end
  end

  # PATCH /settings
  def update
    @user.attributes = user_params

    if @user.save
      redirect_to settings_url, notice: "Successfully updated.!"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, organization_ids: [])
  end
end
