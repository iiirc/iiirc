module SnippetsHelper
  def github_user_url(user)
    username = user.respond_to?(:username) ? user.username : user
    "https://github.com/#{ERB::Util.url_encode(username)}"
  end
end
