# coding: utf-8
require 'spec_helper'

class TmpController < ApplicationController
  def error
    return render_access_denied
  end
end

describe TmpController do
  it 'should return 403 when render_access_denied' do
    get 'error'
    expect(response.status).to be 403
    expect(response.body).to eq "forbidden fruit :)"
  end
end
