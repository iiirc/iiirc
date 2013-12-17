# coding: utf-8
class TweetBot
  FIRST_TWEETS = %w(あっ アッ わっ ワッ !!)

  cattr_accessor :logger
  self.logger ||= Rails.logger

  def self.client
    if Rails.env.production?
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = Settings.twitter.consumer_key
        config.consumer_secret     = Settings.twitter.consumer_secret
        config.access_token        = Settings.twitter.access_token
        config.access_token_secret = Settings.twitter.access_token_secret
      end
    end
  end

  def self.tweet(snippet)
    first_tweet
    second_tweet(snippet)
  end

  private

  def self.first_tweet
    begin
      client.update("%s" % FIRST_TWEETS.sample)
    rescue => e
      logger.warn "TweetBot.first_tweet was failed: %s" % e.message
    end
  end

  def self.second_tweet(snippet)
    begin
      client.update("%s ( %s - %s )" % [snippet.messages.try(:first).try(:content), snippet.title, snippet.url])
    rescue => e
      logger.warn "TweetBot.second_tweet was failed: %s" % e.message
    end
  end
end
