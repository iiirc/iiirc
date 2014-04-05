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

    it 'have link to feed' do
      visit organization_path(organization.login)
      links = Nokogiri.XML(page.html).css("link[rel='alternate'][type='application/atom+xml'][href='#{url_for(controller: :organizations, action: :show, id: organization.login, format: :atom)}']")
      expect(links).not_to be_empty
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

    describe 'Search' do
      context "When using no search engine" do
        before do
          visit root_path
        end

        it "doesn't have search box" do
          expect(page).not_to have_css('.search')
        end
      end

      context "When using Google Custom Search" do
        before do
          allow(Settings).to receive_message_chain(:google_custom_search, :cx).and_return 'gcs-cx'
          visit root_path
        end

        it "has search box" do
          expect(page).to have_css('.search')
        end
      end

    end

    describe 'Atom feed' do
      let!(:snippet) {
        Fabricate(:snippet, organization: organization) do
          before_validation do |snippet|
            snippet.messages << Fabricate(:message)
          end
        end
      }

      it 'should render' do
        visit organization_path(organization.login, format: :atom)

        expect(page.status_code).to be 200
      end

      it 'should be valid atom' do
        visit organization_path(organization.login, format: :atom)

        expect(page.source).to be_valid_atom
      end

      it 'should not render secret snippets' do
        snippet.update_column :published, false
        visit organization_path(organization.login, format: :atom)
        feed = RSS::Parser.parse(page.source)
        expect(feed.items).to be_empty
      end
    end
  end
end
