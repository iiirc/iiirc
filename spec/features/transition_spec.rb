# coding: utf-8
require 'spec_helper'

describe "Transition", type: :feature do
  describe "GET /transition?to=http://yahoo.co.jp" do
    subject { page }

    it "should render" do
      visit transition_path(to: 'http://iiirc.dev/transition?to=http%3A%2F%2Fyahoo.co.jp')
      expect(page.status_code).to be == 200
      expect(subject).to have_content "http://yahoo.co.jp"
    end
  end
end
