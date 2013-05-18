# coding: utf-8
require 'spec_helper'

describe Api::SnippetsController do
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
        response.content_type.should == Mime::JS
      end

      pending "should return expected response" do
        get :show, valid_attributes, format: 'js'
        expect(response.body).to eq "foo"
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
