require 'spec_helper'

describe MessageDecorator do
  describe '#content' do
    let(:message) { Message.new(content: 'http://iiirc.org/').decorate }

    it 'marks URIs up' do
      expect(message.content).to eq('<a href="http://iiirc.org/">http://iiirc.org/</a>')
    end
  end
end
