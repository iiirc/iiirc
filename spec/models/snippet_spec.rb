# coding: utf-8
require 'spec_helper'

describe Snippet do
  it { is_expected.to belong_to :user         }
  it { is_expected.to belong_to :organization }
  it { is_expected.to have_many :messages     }

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
        allow(Rails).to receive_messages(env: ActiveSupport::StringInquirer.new("production"))
      end

      it do
        expect(TweetBot).to receive(:tweet).once
        subject
      end
    end

    context "when Rails.env.pruduction? == true and published == false" do
      let(:published) { false }

      before do
        allow(Rails).to receive_messages(env: ActiveSupport::StringInquirer.new("production"))
      end

      it do
        expect(TweetBot).to receive(:tweet).never
        subject
      end
    end

    context "when Rails.env.pruduction? == false and published == true" do
      let(:published) { true }

      it do
        expect(TweetBot).to receive(:tweet).never
        subject
      end
    end

    context "when Rails.env.pruduction? == false and published == false" do
      let(:published) { false }

      it do
        expect(TweetBot).to receive(:tweet).never
        subject
      end
    end
  end
end
