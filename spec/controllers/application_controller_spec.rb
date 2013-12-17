# coding: utf-8
require 'spec_helper'

class TmpController < ApplicationController
  def error403
    return render_access_denied
  end

  def error404
    return render_not_found
  end
end

describe TmpController do
  before do
    @orig_routes, @routes = @routes, ActionDispatch::Routing::RouteSet.new
    @routes.draw do
      get '/error403' => 'tmp#error403'
      get '/error404' => 'tmp#error404'
    end
  end

  after do
    @routes, @orig_routes = @orig_routes, nil
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
