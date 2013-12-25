# -*- coding: utf-8 -*-
require 'spec_helper'

describe SnippetsController do
  let(:user) { Fabricate(:user) }
  describe "POST preview" do
    before do
      allow(controller).to receive(:current_user) { user }
    end

    it 'respond with HTML of parsed messages' do
      post :preview, { snippet: {title: ''}, content: "00:52 shikakun: すごい！" }

      expect(response.status).to eq 200
      expect(response.body).to have_content '00:52'
    end
  end
end
