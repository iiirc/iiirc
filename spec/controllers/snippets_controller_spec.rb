# -*- coding: utf-8 -*-
require 'spec_helper'

describe SnippetsController do
  let(:user) { Fabricate(:user)    }
  describe "POST preview" do
    before do
      allow(controller).to receive(:current_user) { user }
    end

    it 'respond with JSON of parsed messages' do
      post :preview, { content: "00:52 shikakun: すごい！" }

      expect(response.status).to eq 200
      expect(ActiveSupport::JSON.decode(response.body)).to eq({
        'nick_offset' => 169895279847015425395522194364081377003,
        'messages' => [{'raw_content' => '00:52 shikakun: すごい！', 'time' => '00:52', 'nick' => 'shikakun', 'content' => 'すごい！'}]
      })
    end
  end
end
