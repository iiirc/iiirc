# coding: utf-8
require 'spec_helper'

describe "Snippets" do
  subject { page }

  let(:user)    { Fabricate(:user) }
  let!(:snippet) {
    Fabricate(:snippet, user: user) do
      before_validation do |snippet|
        snippet.messages << Fabricate(:message)
      end
    end
  }

  describe "GET /snippets" do
    it "should render" do
      visit snippets_path
      expect(page.status_code).to be == 200
    end

    context 'no snippet exists' do
      it 'show no snippet' do
        visit snippets_path
        expect(page).not_to have_css("[id~='snippet_']")
      end
    end

    context 'some snippets exist' do
      it 'show snippets' do
        visit snippets_path
        expect(page).to have_css("#snippet_#{snippet.id}")
      end

      context 'unpublished snippets exist' do
        before do
          snippet.update_column :published, false
        end

        it "don't show unpublished snippets" do
          visit snippets_path
          expect(page).not_to have_css("#snippet_#{snippet.id}")
        end
      end
    end

    context "when atom feed requested" do
      it "should render atom feed when specified atom with header" do
        page.driver.header 'Accept', 'application/atom+xml'
        visit snippets_path
        expect(page.response_headers['Content-Type']).to start_with 'application/atom+xml'
      end

      it "should render atom feed when specified atom with extension" do
        visit snippets_path(format: :atom)
        expect(page.response_headers['Content-Type']).to start_with 'application/atom+xml'
      end

      shared_examples "valid atom feed" do
        it "should render valid atom feed" do
          visit snippets_path(format: :atom)
          expect(page.source).to be_valid_atom
        end
      end

      context "when no entry exists" do
        it_behaves_like "valid atom feed"
      end

      context "when some entries exist" do
        before { snippet }

        it_behaves_like "valid atom feed"

        it "should have one entry" do
          visit snippets_path(format: :atom)
          feed = RSS::Parser.parse(page.source)
          expect(feed.items.length).to be == 1
        end

        it "should not render secret entries" do
          snippet.published = false
          snippet.save
          visit snippets_path(format: :atom)
          feed = RSS::Parser.parse(page.source)
          expect(feed.items.length).to be == 0
        end
      end
    end
  end

  describe 'GET /snippets/1' do
    subject { page }

    context 'when specified snippet not exist' do
      it 'should not render' do
        visit snippet_path id: 0
        expect(page.status_code).to be(404)
      end
    end

    context 'when specified snippet exsits' do
      it "show the requested snippet as @snippet" do
        visit snippet_path(snippet.id)
        expect(page).to have_content snippet.title
      end

      context 'when specified snippet unpublished' do
        before do
          snippet.update_column :published, false
        end

        it 'show nothing' do
          visit snippet_path(snippet.id)
          expect(page.status_code).to be(404)
        end
      end

      context 'when specified snippet starred' do
        let!(:star) { Fabricate(:star, message: snippet.messages.first) }

        it 'show user who starred' do
          visit snippet_path(snippet)
          expect(page).to have_css(".starred-by img[data-user-id='#{star.user.id}']")
        end

        it 'icon of who starred should be clickable' do
          visit snippet_path(snippet)
          expect(page).to have_css(".starred-by a[href='#{user_path(star.user.username)}'] img")
        end
      end
    end

    it "respond with 404 when snippet not exist" do
      visit snippet_path(0)
      expect(page.status_code).to be == 404
    end
  end

  describe "GET /snippet/new" do
    it "should render" do
      visit new_snippet_path
      expect(page.status_code).to be == 200
    end
  end

  describe "POST /snippets" do
    context "when current_user is blank" do
      it "should not post a snippet" do
        visit new_snippet_path
        expect(page).to have_content "u can't create a snippet unless logged in."
        expect(page).to_not have_button "Public post!"
      end
    end

    context "when current_user is present" do
      before do
        sign_in(user)
        visit new_snippet_path
      end

      it "should render 'new' without content" do
        click_on 'Public post!'

        expect(page).to have_content '1 error prohibited this snippet from being saved:'

        expect(current_path).to eq snippets_path
      end

      it "should create a snippet with title" do
        fill_in 'snippet_title', :with => 'sugoi'
        fill_in 'content',       :with => '00:52 shikakun: すごい！'

        click_on 'Public post!'

        expect(page).to have_content 'Snippet was successfully created.'

        expect(find('h2')).to have_content 'sugoi'

        expect(find('time')).to have_content '00:52'
        expect(find("span.nick_3")).to have_content 'shikakun:'
        expect(find('p#L1.tweet')).to have_content 'すごい！'

        expect(current_path).to eq snippet_path(id: snippet.id + 1)
      end

      it "should create a snippet without title" do
        fill_in 'content',       :with => '00:52 shikakun: すごい！'

        click_on 'Public post!'

        expect(page).to have_content 'Snippet was successfully created.'

        expect(find('h2')).to have_content(/\A\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}.*\z/)

        expect(find('time')).to have_content '00:52'
        expect(find("span.nick_3")).to have_content 'shikakun:'
        expect(find('p#L1.tweet')).to have_content 'すごい！'

        expect(current_path).to eq snippet_path(id: snippet.id + 1)
      end

      it "should create a snippet as private" do
        fill_in 'content', :with => '00:52 shikakun: すごい！'

        click_on 'Secret post!'

        expect(page).to have_content 'Snippet was successfully created.'

        expect(find('h2')).to have_content(/\A\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}.*\z/)

        expect(find('time')).to have_content('00:52')
        expect(find("span.nick_3")).to have_content 'shikakun:'
        expect(find('p#L1.tweet')).to have_content('すごい！')

        expect(current_path).to match(/\A\/snippets\/\w{20}\z/)
      end
    end
  end

  describe "DELETE /snippet/1", js: true do
    context "when user is not logged in" do
      it "should not show delete button" do
        visit snippet_path(snippet.id)
        expect(page).to_not have_content "Delete Snippet!"
      end
    end

    context "when user is logged in" do
      before do
        sign_in(user)
        visit snippet_path(snippet.id)
      end

      shared_examples 'delete button' do
        it 'should show delete button and delete snippet' do
          expect(page).to have_content "Delete Snippet!"
          click_on "Delete Snippet!"
          expect(page).to have_content "Snippet was successfully deleted."
          expect(current_path).to be == root_path
        end
      end

      it_behaves_like 'delete button'

      context "when snippet is secret" do
        let!(:snippet) {
          Fabricate(:snippet, user: user, published: false) do
            before_validation do |snippet|
              snippet.messages << Fabricate(:message)
            end
          end
        }
        before do
          visit snippet_path(snippet.hash_id)
        end

        it_behaves_like 'delete button'
      end
    end
  end
end
