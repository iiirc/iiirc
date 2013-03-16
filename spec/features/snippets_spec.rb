require 'spec_helper'

describe "Snippets" do
  describe "GET /snippets" do
    subject { page }

    it "should render" do
      visit snippets_path
      expect(page.status_code).to be(200)
    end
  end
end
