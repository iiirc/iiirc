require 'spec_helper'

describe UserDecorator do
  describe '#github_url' do
    let(:user) { Fabricate(:user).decorate }
    before do
      allow(user).to receive(:username) {'iiirc'}
    end

    it 'should return user URI on GitHub' do
      expect(user.github_url).to eq('https://github.com/iiirc')
    end
  end
end
