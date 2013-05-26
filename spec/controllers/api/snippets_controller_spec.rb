# coding: utf-8
require 'spec_helper'

describe Api::SnippetsController do
  render_views

  let(:snippet) {
    Fabricate(:snippet, published: published) do
      before_validation do |snippet|
        snippet.messages << Fabricate(:message)
      end
    end
  }
  let(:published) { true }

  before do
    request.env["HTTP_ACCEPT"] = 'text/javascript'
  end

  def valid_attributes
    { id: snippet.id }
  end

  def invalid_attributes
    { id: 0 } # stub as non-existed snippet
  end

  describe "GET show" do
    context "when snippet is not exist" do
      it "should return 404" do
        get :show, invalid_attributes, format: 'js'
        expect(response.status).to eq 404
      end
    end

    context "when snippet is public" do
      it "should return http success" do
        get :show, valid_attributes, format: 'js'
        expect(response.status).to eq 200
      end

      it "should return expected response" do
        get :show, valid_attributes, format: 'js'
        expect(response.body).to match(/document\.write\(".*content.*"\);/)
        expect(response).to render_template(partial: 'snippet')
        expect(response.content_type).to eq Mime::JS
      end
    end

    context "when snippet is secret" do
      let(:published) { false }

      it "should return 404" do
        get :show, valid_attributes, format: 'js'
        expect(response.status).to eq 404
      end
    end
  end
end
