require 'spec_helper'

describe Organization do
  it { should have_many :user_organizations }
  it { should have_many :users }
  it { should have_many :snippets }

  describe "#to_param" do
    let(:organization) { Fabricate(:organization) }

    it { expect(organization.to_param).to eq organization.login }
  end
end
