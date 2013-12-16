# coding: utf-8
require 'spec_helper'

describe TweetBot do
  let(:snippet) {
    Fabricate(:snippet) do
      before_validation do |snippet|
        snippet.messages << Fabricate(:message)
      end
    end
  }

  describe '.tweet_bot' do
    subject { described_class.tweet(snippet) }

    context "when successfuly update" do
      it do
        Twitter.should_receive(:update).twice
        subject
      end
    end

    context "when first_tweet is failed" do
      before do
        Twitter.stub(:update).and_raise(Twitter::Error::Forbidden)
        TweetBot.stub(:second_tweet) # doesn't test as stub
      end

      it "should logger is invoked" do
        Rails.logger.should_receive(:warn).at_least(1).times
        subject
      end
    end

    context "when second_tweet is failed" do
      before do
        Twitter.stub(:update).and_raise(Twitter::Error::Forbidden)
        TweetBot.stub(:first_tweet) # doesn't test as stub
      end

      it "should logger is invoked" do
        Rails.logger.should_receive(:warn).at_least(1).times
        subject
      end
    end
  end
end
