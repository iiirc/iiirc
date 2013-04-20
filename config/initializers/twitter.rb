require 'twitter'

if Rails.env.production?
  Twitter.configure do |config|
    config.consumer_key       = Settings.twitter.consumer_key
    config.consumer_secret    = Settings.twitter.consumer_secret
    config.oauth_token        = Settings.twitter.oauth_token
    config.oauth_token_secret = Settings.twitter.oauth_token_secret
  end
end
