require "spec_helper"

describe SnippetsController do
  describe "routing" do

    it "routes to #index" do
      get("/snippets").should route_to("snippets#index")
    end

    it "routes to #new" do
      get("/snippets/new").should route_to("snippets#new")
    end

    it "routes to #show" do
      get("/snippets/1").should route_to("snippets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/snippets/1/edit").should route_to("snippets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/snippets").should route_to("snippets#create")
    end

    it "routes to #update" do
      put("/snippets/1").should route_to("snippets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/snippets/1").should route_to("snippets#destroy", :id => "1")
    end

  end
end
