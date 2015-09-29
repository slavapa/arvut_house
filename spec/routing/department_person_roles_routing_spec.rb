require "spec_helper"

describe DepartmentPersonRolesController do
  describe "routing" do

    it "routes to #index" do
      get("/department_person_roles").should route_to("department_person_roles#index")
    end

    it "routes to #new" do
      get("/department_person_roles/new").should route_to("department_person_roles#new")
    end

    it "routes to #show" do
      get("/department_person_roles/1").should route_to("department_person_roles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/department_person_roles/1/edit").should route_to("department_person_roles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/department_person_roles").should route_to("department_person_roles#create")
    end

    it "routes to #update" do
      put("/department_person_roles/1").should route_to("department_person_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/department_person_roles/1").should route_to("department_person_roles#destroy", :id => "1")
    end

  end
end
