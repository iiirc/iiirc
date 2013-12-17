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
        expect(described_class.client).to receive(:update).twice
        subject
      end
    end

    context "when first_tweet is failed" do
      before do
        allow(described_class.client).to receive(:update).and_raise(Twitter::Error::Forbidden)
        allow(TweetBot).to receive(:second_tweet) # doesn't test as stub
      end

      it "should logger is invoked" do
        expect(Rails.logger).to receive(:warn).at_least(1).times
        subject
      end
    end

    context "when second_tweet is failed" do
      before do
        allow(described_class.client).to receive(:update).and_raise(Twitter::Error::Forbidden)
        allow(TweetBot).to receive(:first_tweet) # doesn't test as stub
      end

      it "should logger is invoked" do
        expect(Rails.logger).to receive(:warn).at_least(1).times
        subject
      end
    end
  end
end
