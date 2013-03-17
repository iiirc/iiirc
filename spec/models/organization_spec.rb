require 'spec_helper'

describe Organization do
  it { should have_many :user_organizations }
  it { should have_many :users }
  it { should have_many :snippets }
end
