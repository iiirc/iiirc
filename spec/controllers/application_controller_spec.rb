# coding: utf-8
require 'spec_helper'

class TmpController < ApplicationController
  before_action :require_login, only: %w(require_login_action)

  def require_login_action
  end

  def not_require_login_action
    render text: 'hello'
  end

  def error400
    return render_bad_request
  end

  def error403
    return render_access_denied
  end

  def error404
    return render_not_found
  end
end

describe TmpController do
  it 'should return 403 when require_login is specified in before_action' do
    get 'require_login_action'
    expect(response.status).to be 403
    expect(response.body).to eq "forbidden fruit :)"
  end

  it 'should return 200 when require_login is not specified' do
    get 'not_require_login_action'
    expect(response.status).to be 200
  end

  it 'should return 400 when render_access_denied' do
    get 'error400'
    expect(response.status).to be 400
    expect(response.body).to eq "400 Bad Request"
  end

  it 'should return 403 when render_access_denied' do
    get 'error403'
    expect(response.status).to be 403
    expect(response.body).to eq "forbidden fruit :)"
  end

  it 'should return 404 when render_not_found' do
    get 'error404'
    expect(response.status).to be 404
    expect(response.body).to eq "404 not found"
  end
end
