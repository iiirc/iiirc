# coding: utf-8
require 'spec_helper'

describe Snippet do
  it { should belong_to :user         }
  it { should belong_to :organization }
  it { should have_many :messages     }

  let(:snippet) {
    Fabricate(:snippet, published: published) do
      before_validation do |snippet|
        snippet.messages.build(raw_content: "00:52 shikakun: すごい！")
      end
    end
  }

  let(:published) {}

  describe '#url' do
    it { expect(snippet.url).to eq "http://iiirc.org/snippets/#{snippet.id}" }
  end

  describe '#tweet_bot' do
    subject { snippet }

    context "when Rails.env.pruduction? == true and published == true" do
      let(:published) { true }

      before do
        Rails.stub(env: ActiveSupport::StringInquirer.new("production"))
      end

      it do
        TweetBot.should_receive(:tweet).once
        subject
      end
    end

    context "when Rails.env.pruduction? == true and published == false" do
      let(:published) { false }

      before do
        Rails.stub(env: ActiveSupport::StringInquirer.new("production"))
      end

      it do
        TweetBot.should_receive(:tweet).never
        subject
      end
    end

    context "when Rails.env.pruduction? == false and published == true" do
      let(:published) { true }

      it do
        TweetBot.should_receive(:tweet).never
        subject
      end
    end

    context "when Rails.env.pruduction? == false and published == false" do
      let(:published) { false }

      it do
        TweetBot.should_receive(:tweet).never
        subject
      end
    end
  end
end
