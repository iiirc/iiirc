# -*- coding: utf-8 -*-
require 'spec_helper'

describe PubsubhubbubPublisher do
  subject { PubsubhubbubPublisher.new('http://example.net', :test) }

  it 'post to hub' do
    response = subject.perform
    expect(response.status).to be 204
  end

  it 'post to hub on creating snippet' do
    PubsubhubbubPublisher.should_receive(:perform)

    user = Fabricate(:user)
    snippet = user.snippets.build(published: true)
    snippet.messages.build raw_content: 'raw content'
    snippet.save
  end

  it "don't post to hub on creating secret snippet" do
    PubsubhubbubPublisher.should_not_receive(:perform)

    user = Fabricate(:user)
    snippet = user.snippets.build(published: false)
    snippet.messages.build raw_content: 'raw content'
    snippet.save
  end
end
