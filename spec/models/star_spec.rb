require 'spec_helper'

describe Star do
  it { should belong_to :user }
  it { should belong_to :message }
end
