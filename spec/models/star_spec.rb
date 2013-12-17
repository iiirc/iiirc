require 'spec_helper'

describe Star do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :message }
end
