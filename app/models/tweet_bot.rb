# coding: utf-8
class TweetBot
  FIRST_TWEETS = %w(あっ アッ わっ ワッ !!)

  cattr_accessor :logger
  self.logger ||= Rails.logger

  def self.tweet(snippet)
    first_tweet
    second_tweet(snippet)
  end

  private

  def self.first_tweet
    begin
      Twitter.update("%s" % FIRST_TWEETS.sample)
    rescue => e
      logger.warn "TweetBot.first_tweet was failed: %s" % e.message
    end
  end

  def self.second_tweet(snippet)
    begin
      Twitter.update("%s ( %s - %s )" % [snippet.messages.try(:first).try(:content), snippet.title, snippet.url])
    rescue => e
      logger.warn "TweetBot.second_tweet was failed: %s" % e.message
    end
  end
end
