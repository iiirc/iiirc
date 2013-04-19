require 'twitter'

if Rails.env.production?
  Twitter.configure do |config|
    config.consumer_key       = Settings.twitter.client_id
    config.consumer_secret    = Settings.twitter.client_id
    config.oauth_token        = Settings.twitter.client_id
    config.oauth_token_secret = Settings.twitter.client_id
  end
end
