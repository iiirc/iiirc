require 'spec_helper'

describe MessageDecorator do
  let(:snippet) {
    Fabricate(:snippet) do
      before_validation do |snippet|
        snippet.messages << Fabricate(:message)
      end
    end
  }

  describe '#content' do
    let!(:message) { snippet.messages.first.decorate }

    before do
      message.content = 'http://www.iiirc.org/'
    end

    it 'marks URIs up' do
      expect(message.content).to eq('<a href="http://www.iiirc.org/">http://www.iiirc.org/</a>')
    end

    context 'when secret snippet' do
      before do
        message.snippet.published = false
      end

      it 'marks URIs up as links to transition pages' do
        expect(message.content).to eq('<a href="/transition?to=http%3A%2F%2Fwww.iiirc.org%2F">http://www.iiirc.org/</a>')
      end
    end

    context 'when including image URI' do
      let(:message) { snippet.messages.first.decorate }

      before do
        message.content = 'https://secure.gravatar.com/avatar/8bafb8feb0f769fb5c46521c53f21eb6'
      end

      it 'marks URIs up with a and img tag' do
        expect(message.content).to eq('<a href="https://secure.gravatar.com/avatar/8bafb8feb0f769fb5c46521c53f21eb6">https://secure.gravatar.com/avatar/8bafb8feb0f769fb5c46521c53f21eb6</a><br><a href="https://secure.gravatar.com/avatar/8bafb8feb0f769fb5c46521c53f21eb6"><img alt="" src="https://secure.gravatar.com/avatar/8bafb8feb0f769fb5c46521c53f21eb6" /></a>')
      end

      context 'when secret snippet' do
        before do
          message.snippet.published = false
        end

        it 'marks URIs up with a and img tag using image proxy' do
          expect(message.content).to eq '<a href="/transition?to=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2F8bafb8feb0f769fb5c46521c53f21eb6">https://secure.gravatar.com/avatar/8bafb8feb0f769fb5c46521c53f21eb6</a><br><a href="/transition?to=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2F8bafb8feb0f769fb5c46521c53f21eb6"><img alt="" src="/image_proxy?of=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2F8bafb8feb0f769fb5c46521c53f21eb6" /></a>'
        end
      end
    end
  end
end
