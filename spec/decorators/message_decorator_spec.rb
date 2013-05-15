require 'spec_helper'

describe MessageDecorator do
  describe '#content' do
    let(:message) { Message.new(content: 'http://iiirc.org/').decorate }

    it 'marks URIs up' do
      expect(message.content).to eq('<a href="http://iiirc.org/">http://iiirc.org/</a>')
    end

    context 'when including image URI' do
      let(:message) { Message.new(content: 'http://iiirc.org/assets/iiirc.gif').decorate }

      it 'marks URIs up with a and img tag' do
        expect(message.content).to eq('<a href="http://iiirc.org/assets/iiirc.gif">http://iiirc.org/assets/iiirc.gif<br><img src="http://iiirc.org/assets/iiirc.gif" alt=""></a>')
      end
    end
  end
end
