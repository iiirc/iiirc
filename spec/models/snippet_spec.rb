require 'spec_helper'

describe Snippet do
  it { should belong_to :user         }
  it { should belong_to :organization }
  it { should have_many :messages     }

  describe '#url' do
    let(:snippet) { Fabricate(:snippet) }

    it { expect(snippet.url).to eq "http://iiirc.org/snippets/#{snippet.id}" }
  end

  describe '#tweet_bot' do
    let(:snippet) { Fabricate(:snippet, published: published) }

    context "when published == true" do
      let(:published) { true }

      it do
        Twitter.should_receive(:update).with("new iiirc - #{snippet.title} - #{snippet.url}")
        snippet.send(:tweet_bot)
      end
    end

    context "when published == false" do
      let(:published) { false }

      it do
        Twitter.should_not_receive(:update).with("new iiirc - #{snippet.title} - #{snippet.url}")
        snippet.send(:tweet_bot)
      end
    end
  end
end
