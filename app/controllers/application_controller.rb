class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def render_bad_request(message='400 Bad Request')
    render text: message, status: 400, layout: false
  end

  def render_access_denied
    render text: "forbidden fruit :)", status: 403, layout: false
  end

  def render_not_found
    render file: 'public/404.html', status: 404
  end
end
