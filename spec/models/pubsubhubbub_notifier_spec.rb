require 'spec_helper'

describe PubsubhubbubNotifier do
  it 'should have instances for hubs on start' do
    expect(PubsubhubbubNotifier.instances.length).to eq Settings.pubsubhubbub.length
  end

  it 'should call notify method of all instances' do
    notifier = PubsubhubbubNotifier.new('https://example.net/publish')
    expect(notifier).to receive(:notify).once
    PubsubhubbubNotifier.instances = [notifier]

    PubsubhubbubNotifier.notify
  end

  it 'should log on error' do
    notifier = PubsubhubbubNotifier.new('https://example.net/publish')
    allow(notifier).to receive(:notify) { raise 'Error!' }
    PubsubhubbubNotifier.instances = [notifier]
    expect(Rails.logger).to receive(:warn).with('[PubsubhubbubNotifier.notify]ERROR: Error!')

    PubsubhubbubNotifier.notify
  end

  context 'snippet is posted' do

    it 'should notify for published' do
      expect(PubsubhubbubNotifier).to receive(:notify)
      Fabricate(:snippet, published: true) do
        before_validation do |snippet|
          snippet.messages << Fabricate(:message)
        end
      end
    end

    it 'should not notify for secret snippet' do
      expect(PubsubhubbubNotifier).not_to receive(:notify)
      Fabricate(:snippet, published: false) do
        before_validation do |snippet|
          snippet.messages << Fabricate(:message)
        end
      end
    end
  end

  describe 'instance' do
    subject { PubsubhubbubNotifier.new('https://example.net/publish') }
    before do
      Rails.application.routes.default_url_options[:host] = 'example.com'
    end

    it 'should post to hub URI' do
      expect(subject.client).to receive(:post)
        .with('/publish', 'hub.mode' => 'publish', 'hub.url' => 'http://www.iiirc.org/snippets.atom')
        .once
        .and_return double(status: 204)
      subject.notify
    end

    it 'should log on error' do
      allow(subject.client).to receive(:post).and_return double(status: 404, body: 'Error!')
      expect(Rails.logger).to receive(:warn).with('[PubsubhubbubNotifier#notify]ERROR: status: 404, body: Error!').once
      subject.notify
    end
  end
end
