require 'spec_helper'

describe "Snippets" do
  subject { page }

  describe "GET /snippets" do
    it "should render" do
      visit snippets_path
      expect(page.status_code).to be == 200
    end
  end

  describe "GET /snippet/1" do
    it "show the requested snippet as @snippet" do
      snippet = Fabricate(:snippet)
      visit snippet_path(snippet.id)
      expect(page).to have_content snippet.title
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
