require 'spec_helper'

describe UserDecorator do
  describe '#github_url' do
    let(:user) { Fabricate(:user).decorate }

    it 'should return user URI on GitHub' do
      expect(user.github_url).to eq('https://github.com/alice0')
    end
  end
end
