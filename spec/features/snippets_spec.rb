require 'spec_helper'

describe "Snippets" do
  subject { page }

  describe "GET /snippets" do
    it "should render" do
      visit snippets_path
      expect(page.status_code).to be == 200
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
        let!(:snippet) { Fabricate(:snippet) }

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

  describe "GET /snippet/1" do
    it "show the requested snippet as @snippet" do
      snippet = Fabricate(:snippet)
      visit snippet_path(snippet.id)
      expect(page).to have_content snippet.title
    end

    it "respond with 404 when snippet not exist" do
      visit snippet_path(0)
      expect(page.status_code).to be == 404
    end
  end

  describe "DELETE /snippet/1", js: true do
    let(:user)    { Fabricate(:user) }
    let(:snippet) { Fabricate(:snippet, user: user) }

    context "when user is not logged in" do
      it "should not show delete button" do
        visit snippet_path(snippet.id)
        expect(page).to_not have_content "Delete Snippet!"
      end
    end

    context "when user is logged in" do
      before { sign_in(user) }

      it "should show delete button and delete snippet" do
        visit snippet_path(snippet.id)
        expect(page).to have_content "Delete Snippet!"
        click_on "Delete Snippet!"
        expect(page).to have_content "Snippet was successfully deleted."
        expect(current_path).to be == root_path
      end
    end
  end
end
