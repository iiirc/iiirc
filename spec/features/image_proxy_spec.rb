# coding: utf-8
require 'spec_helper'

describe 'ImageProxy' do
  describe 'GET /image_proxy?of=' do
    subject { page }

    it 'should render' do
      visit image_proxy_path(of: 'https://secure.gravatar.com/avatar/8bafb8feb0f769fb5c46521c53f21eb6')
      expect(page.status_code).to be 200
      expect(page.response_headers['Content-Type']).to start_with 'image/png'
    end
  end

  describe 'GET /image_proxy' do
    it 'respond with 400' do
      visit image_proxy_path
      expect(page.status_code).to be 400
    end
  end

  describe 'GET /image_proxy?of=https://github.com/' do
    it 'respond with 400' do
      visit image_proxy_path(of: 'https://github.com/')
      expect(page.status_code).to be 400
    end
  end
end
