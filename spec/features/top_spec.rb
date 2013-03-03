# coding: utf-8
require 'spec_helper'

describe "Top" do
  describe "GET /" do
    subject { page }

    it "should render" do
      visit root_path
      expect(page.status_code).to be == 200
    end
  end
end
