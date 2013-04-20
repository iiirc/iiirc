module SnippetsHelper
  def github_user_url(username)
    "https://github.com/#{ERB::Util.url_encode(username)}"
  end
end
