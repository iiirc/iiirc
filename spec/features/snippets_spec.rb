require 'spec_helper'

describe "Snippets" do
  subject { page }

  describe "GET /snippets" do
    it "should render" do
      visit snippets_path
      expect(page.status_code).to be == 200
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
    end
  end
end
