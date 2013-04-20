require 'spec_helper'

describe "Snippets" do
  subject { page }

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
      let!(:snippet) { Fabricate(:snippet) }

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
  end

  describe 'GET /snippets/1' do
    subject { page }

    context 'when specified snippet not exist' do
      it 'should not render' do
        visit snippet_path id: 1
        expect(page.status_code).to be(404)
      end
    end

    context 'when specified snippet exsits' do
      let(:snippet) { Fabricate(:snippet) }

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
        let!(:star) { Fabricate(:star) }

        it 'show user who starred' do
          visit snippet_path(star.message.snippet)
          expect(page).to have_css(".starred-by img[data-user-id='#{star.user.id}']")
        end
      end
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
