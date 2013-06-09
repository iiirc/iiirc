class Api::OrganizationsController < ApplicationController
   respond_to :json

  def index
    @organizations = Organization.has_snippets
    respond_with @organizations
  end
end
