require "spec_helper"

describe PaymetTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/paymet_types").should route_to("paymet_types#index")
    end

    it "routes to #new" do
      get("/paymet_types/new").should route_to("paymet_types#new")
    end

    it "routes to #show" do
      get("/paymet_types/1").should route_to("paymet_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/paymet_types/1/edit").should route_to("paymet_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/paymet_types").should route_to("paymet_types#create")
    end

    it "routes to #update" do
      put("/paymet_types/1").should route_to("paymet_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/paymet_types/1").should route_to("paymet_types#destroy", :id => "1")
    end

  end
end
