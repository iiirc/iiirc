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
    context "when published == true" do
      let(:published) { true }

      it do
        Twitter.should_receive(:update).twice
        snippet.send(:tweet_bot)
      end
    end

    context "when published == false" do
      let(:published) { false }

      it do
        Twitter.should_receive(:update).never
        snippet.send(:tweet_bot)
      end
    end
  end
end
