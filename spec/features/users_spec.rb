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
      let(:snippet) { Fabricate(:snippet) }
      let(:user)    { snippet.user }

      before do
        visit user_path(user.username)
      end

      it 'should render' do
        expect(page).to have_content(user.username)
      end

      it "show user's snippets" do
        expect(page).to have_css("#snippet_#{snippet.id}")
      end
    end
  end
end
