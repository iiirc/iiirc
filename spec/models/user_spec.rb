# coding: utf-8

require 'spec_helper'

describe User do
  it { is_expected.to have_many :snippets }
  it { is_expected.to have_many :user_organizations }
  it { is_expected.to have_many :organizations }
  it { is_expected.to have_many :stars }

  describe "#find_or_create_organizations" do
    let(:user) { Fabricate(:user) }
    subject    { user }

    context "when organization is created already" do
      let!(:organization) { Fabricate(:organization) }

      before do
        expected_response = double("org", id: organization.original_id, login: organization.login )
        allow(Octokit::Client).to receive_message_chain(:new, :organizations).and_return [expected_response]
      end

      it "should return organization" do
        expect(subject.find_or_create_organizations).to eq [organization]
      end

      it "should not create organization" do
        expect {
          subject.find_or_create_organizations
        }.to change { Organization.count }.by(0)
      end
    end

    context "when organization is not created yet" do
      before do
        expected_response = double("org", id: 1, login: "new_org_which_is_not_registered" )
        allow(Octokit::Client).to receive_message_chain(:new, :organizations).and_return [expected_response]
      end

      it "should return new organization" do
        expect(subject.find_or_create_organizations.first.login).to eq "new_org_which_is_not_registered"
      end

      it "should create organization" do
        expect {
          subject.find_or_create_organizations
        }.to change { Organization.count }.by(1)
      end
    end
  end

  describe ".create_with_omniauth" do
    subject { described_class.create_with_omniauth(auth) }

    context "with valid params" do
      let(:auth) {
        {
          provider: "github",
          uid: "bogus_id",
          info: {
            nickname: "banyan",
            email:    "ameutau@gmail.com"
          },
          credentials: {
            token: "foobar"
          }
        }
      }

      it "should create a user" do
        expect {
          subject
        }.to change {
          User.count
        }.by(1)
      end
    end

    context "with invalid params" do
      let(:auth) { {} }

      it do
        expect {
          subject
        }.to raise_error
      end
    end
  end
end
