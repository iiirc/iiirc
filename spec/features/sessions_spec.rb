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
    before do
      @organization = Fabricate(:organization)
      User.any_instance.stub(:find_or_create_organizations).and_return([@organization])
    end

    context "when user is a new user" do
      let(:user) { Fabricate.attributes_for(:user) }

      context "when returns valid response" do
        it "should create a user" do
          expect {
            sign_in(user)
            check("user_organization_ids")
            find_button('Sign up!').click
          }.to change { User.count }.by(1)
        end

        it {
          sign_in(user)
          check("user_organization_ids")
          find_button('Sign up!').click
          expect(subject).to have_content "Sign out"
        }
      end

      context "when returns invalid response" do
        before do
          User.any_instance.stub(:save).and_return(false)
        end

        it "should not create a user" do
          expect {
            sign_in(user)
            check("user_organization_ids")
            find_button('Sign up!').click
          }.to change { User.count }.by(0)
        end

        it "should re-render 'new'" do
          sign_in(user)
          check("user_organization_ids")
          find_button('Sign up!').click
          expect(subject).to_not have_content "Sign out"
          expect(subject).to have_button 'Sign up!'
        end
      end
    end

    context "when user has already activated" do
      let!(:user) { Fabricate(:user) }

      context "when returns valid response" do
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
    end
  end

  describe 'DELETE /signout' do
    context 'when logged in as a user' do
      let!(:user) { Fabricate(:user) }

      before { sign_in(user) }

      it {
        sign_out
        expect(current_path).to be == '/'
        expect(subject).to have_content 'Sign in'
        expect(subject).to have_content 'Successfully signed out.'
      }
    end
  end
end
