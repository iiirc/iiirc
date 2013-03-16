require 'spec_helper'

describe "Snippets" do
  describe "GET /snippets" do
    subject { page }

    it "should render" do
      visit snippets_path
      expect(page.status_code).to be(200)
    end
  end

  describe 'GET /snippets/1' do
    subject { page }

    it 'should not render' do
      visit snippet_path id: 1
      expect(page.status_code).to be(404)
    end
  end
end
