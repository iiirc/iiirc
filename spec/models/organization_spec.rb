require 'spec_helper'

describe Organization do
  it { is_expected.to have_many :user_organizations }
  it { is_expected.to have_many :users }
  it { is_expected.to have_many :snippets }

  describe "#to_param" do
    let(:organization) { Fabricate(:organization) }

    it { expect(organization.to_param).to eq organization.login }
  end
end
