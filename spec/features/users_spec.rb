require 'spec_helper'

describe 'Users' do
  subject { page }

  describe 'GET /users/alice0' do
    context 'when user not exist' do
      it 'should not render' do
        visit user_path('iiirc')
        expect(page.status_code).to eq(404)
      end
    end

    context 'when user exists' do
      let(:user) { Fabricate(:user) }
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

      it 'have link to feed' do
        visit user_path(user.username)
        links = Nokogiri.XML(page.html).css("link[rel='alternate'][type='application/atom+xml'][href='#{url_for(controller: :users, action: :show, id: user.username, format: :atom)}']")
        expect(links).not_to be_empty
      end

      context 'when so many snippets exist' do
        before do
          Snippet.default_per_page.times do
            Fabricate(:snippet, user: user) do
              before_validation do |snippet|
                snippet.messages << Fabricate(:message)
              end
            end
          end
        end

        it 'have pagination link' do
          visit user_path(user.username)
          expect(page).to have_css("a[href='#{user_path(id: user.username, page: 2)}']")
        end
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

      context 'when user belongs to no organizations' do
        it "don't have organization section" do
          visit user_path(user.username)

          expect(page).not_to have_css('.organizations')
        end
      end

      context 'when user belongs to no organizations' do
        let(:organization) { Fabricate(:organization) }
        before do
          organization.users << user
          visit user_path(user.username)
        end

        it 'have list of organizations' do
          expect(page).to have_css('.organizations')
        end

        it 'have link to organization pages' do
          expect(page).to have_link(organization.login)
          expect(page).to have_css("a[href='#{organization_path(organization.login)}']")
        end
      end

      describe 'Atom feed' do
        it 'should render' do
          visit user_path(user.username, format: :atom)
          expect(page.status_code).to be 200
        end

        it 'should be valid atom' do
          visit user_path(user.username, format: :atom)
          expect(page.source).to be_valid_atom
        end

        it 'should not render secret snippets' do
          snippet.update_column :published, false
          visit user_path(user.username, format: :atom)
          feed = RSS::Parser.parse(page.source)
          expect(feed.items).to be_empty
        end
      end
    end
  end

  describe 'GET /settings' do
    context 'when user is not logged in' do
      it 'should returns 403 response' do
        visit settings_path
        expect(page.status_code).to be 403
      end
    end

    context 'when user is logged in' do
      let(:user)         { Fabricate(:user) }
      let(:organization) { Fabricate(:organization) }

      before do
        User.any_instance.stub(:find_or_create_organizations).and_return([organization])
        sign_in(user)
        visit settings_path
      end

      it 'should render' do
        expect(page.status_code).to be 200
      end

      context 'when update successfully' do
        context 'update email' do
          it 'should update email' do
            fill_in 'user_email', with: 'bogus@example.org'
            click_on 'Update!'

            expect(find_field('user_email').value).to eq("bogus@example.org")
            expect(page).to have_content "Successfully updated!"
          end
        end

        context 'update organization' do
          let!(:user_organization) { Fabricate(:user_organization, user: user, organization: organization) }

          it 'should update organizations' do
            expect(find("#user_organization_ids_#{organization.id}").checked?).to_not eq "checked"
            check(organization.login)
            click_on 'Update!'

            expect(page).to have_content "Successfully updated!"
            expect(find("#user_organization_ids_#{organization.id}").checked?).to eq "checked"
          end
        end
      end

      context 'when update failed' do
        before do
          User.any_instance.stub(:save).and_return false
        end

        it 'should update settings' do
          fill_in 'user_email', with: 'bogus@example.org'
          click_on 'Update!'

          expect(current_path).to eq settings_path
        end
      end
    end
  end
end
