require 'spec_helper'

describe 'Users' do
  subject { page }

  describe 'GET /users/alice0' do
    context 'when user not exist' do
      it 'should nt render' do
        visit user_path('iiirc')
        expect(page.status_code).to eq(404)
      end
    end

    context 'when user exists' do
      let(:user)    { Fabricate(:user) }
      let!(:snippet) {
        Fabricate(:snippet, user: user) do
          before_validation do |snippet|
            snippet.messages << Fabricate(:message)
          end
        end
      }

      before do
        visit user_path(user.username)
      end

      it 'should render' do
        expect(page).to have_content(user.username)
      end

      it "show user's snippets" do
        expect(page).to have_css("#snippet_#{snippet.id}")
      end

      it 'have link to each snippet' do
        expect(page).to have_css("a[href='#{snippet_path(snippet)}']")
      end

      it "don't show unpublished snippets" do
        snippet.update_column :published, false
        visit user_path(user.username)
        expect(page).not_to have_css('[id~="snippet_"]')
      end

      context 'signed in as the user' do
        before do
          sign_in(user)
          snippet.published = false
          snippet.send :set_hash_id
          snippet.save
        end

        it "show unpublished snippets" do
          visit user_path(user.username)
          expect(page).to have_css("#snippet_#{snippet.id}")
          expect(page).to have_css("a[href='/snippets/#{snippet.hash_id}']")
        end
      end
    end
  end
end
