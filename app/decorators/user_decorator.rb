class UserDecorator < Draper::Decorator
  GITHUB_URL_STEM = 'https://github.com'
  delegate_all

  def github_url
    "#{GITHUB_URL_STEM}/#{ERB::Util.url_encode(username)}"
  end
end
