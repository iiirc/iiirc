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

    context "When using no search engine" do
      before do
        visit root_path
      end

      it "doesn't have search box" do
        expect(page).not_to have_css('.search')
      end
    end

    context "When using Google Custom Search" do
      before do
        allow(Settings).to receive_message_chain(:google_custom_search, :cx).and_return 'gcs-cx'
        visit root_path
      end

      it "has search box" do
        expect(page).to have_css('#search')
      end
    end
  end
end
