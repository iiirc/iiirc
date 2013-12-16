require 'spec_helper'

describe UserOrganization do
  it { should belong_to :user }
  it { should belong_to :organization }
end
