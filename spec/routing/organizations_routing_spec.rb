require "spec_helper"

describe OrganizationsController do
  describe "routing" do

    it "routes to #index" do
      get("/organizations").should route_to("organizations#index")
    end

    it "routes to #show" do
      get("/organizations/1").should route_to("organizations#show", :id => "1")
    end

  end
end
