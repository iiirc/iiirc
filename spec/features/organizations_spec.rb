# coding: utf-8
require 'spec_helper'

describe "Organizations" do
  describe "GET /organizations" do
    subject { page }

    it "should render" do
      visit organizations_path
      expect(page.status_code).to be == 200
    end
  end
end
