require "spec_helper"

describe OrganizationsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/organizations")).to route_to("organizations#index")
    end

    it "routes to #show" do
      expect(get("/organizations/1")).to route_to("organizations#show", :id => "1")
    end

  end
end
