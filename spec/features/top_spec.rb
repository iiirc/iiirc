# coding: utf-8
require 'spec_helper'

describe "Top" do
  describe "GET /" do
    subject { page }

    it "should render" do
      visit root_path
      expect(page.status_code).to be == 200
    end

    it 'have link to feed' do
      visit root_path
      links = Nokogiri.HTML(page.html).css('link[rel="alternate"][type="application/atom+xml"]')
      expect(links).not_to be_empty
    end
  end
end
