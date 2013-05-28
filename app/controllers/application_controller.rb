class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    return render_access_denied if current_user.blank?
  end

  def render_bad_request(message = '400 Bad Request')
    render text: message, status: 400, layout: false
  end

  def render_access_denied(message = 'forbidden fruit :)')
    render text: message, status: 403, layout: false
  end

  def render_not_found(message = '404 not found')
    render text: message, status: 404, layout: false
  end
end
