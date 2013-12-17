require 'spec_helper'

describe UserOrganization do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :organization }
end
