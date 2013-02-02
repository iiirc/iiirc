# coding: utf-8

class OrganizationsController < ApplicationController
  # GET /organizations
  # GET /organizations.json
  def index
    # TODO 0人以外の Organization を表示させる
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  end

  # GET /organizations/paperboy-all
  # GET /organizations/paperboy-all.json
  def show
    @organization = Organization.find_by_login(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end
end
