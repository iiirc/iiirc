# coding: utf-8
require 'spec_helper'

describe "Sessions" do
  subject { page }

  describe "GET /" do
    it "should render" do
      visit root_path
      expect(subject).to have_content "Sign in"
    end
  end

  describe "GET /signin" do
    context "when user is a new user" do
      let(:user) { Fabricate.attributes_for(:user) }

      context "when valid" do
        it "should create a user" do
          expect {
            sign_in(user)
          }.to change { User.count }.by(1)
        end

        it {
          sign_in(user)
          expect(subject).to have_content "Sign out"
        }
      end

      pending "when invalid" do
      end
    end

    context "when user has already activated" do
      let!(:user) { Fabricate(:user) }

      context "when valid" do
        it "should not create a user" do
          expect {
            sign_in(user)
          }.to change { User.count }.by(0)
        end

        it {
          sign_in(user)
          expect(subject).to have_content "Sign out"
        }
      end

      pending "when invalid" do
      end
    end
  end
end
