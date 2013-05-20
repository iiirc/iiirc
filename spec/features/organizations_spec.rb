# coding: utf-8
require 'spec_helper'

describe "Organizations" do
  describe "GET /organizations" do
    subject { page }

    it "should render" do
      visit organizations_path
      expect(page.status_code).to be == 200
    end
  end

  describe "GET /organizations/paperboy-all" do
    let(:organization) { Fabricate(:organization, login: "paperboy-all") }

    subject { page }

    it "should render" do
      visit organization_path(organization.login)
      expect(page.status_code).to be == 200
    end

    context 'when organization has mebers' do
      let(:user) { Fabricate(:user) }
      before do
        organization.users << user
      end

      it 'should render link to user page of members' do
        visit organization_path(organization.login)
        expect(page).to have_link(user.username)
      end
    end

    describe 'snippets' do
      let(:user) { Fabricate(:user) }
      let!(:snippet) {
        Fabricate(:snippet, user: user, organization: organization) do
          before_validation do |snippet|
            snippet.messages << Fabricate(:message)
          end
        end
      }

      it 'render snippets related to organization' do
        visit organization_path(organization.login)

        expect(page).to have_css("#snippet_#{snippet.id}")
      end

      it "don't render secret snippets" do
        snippet.update_column :published, false
        visit organization_path(organization.login)

        expect(page).not_to have_css("#snippet_#{snippet.id}")
      end
    end
  end
end
