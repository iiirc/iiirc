# coding: utf-8

require 'spec_helper'

describe User do
  it { should have_many :snippets }
  it { should have_many :user_organizations }
  it { should have_many :organizations }
  it { should have_many :stars }

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
