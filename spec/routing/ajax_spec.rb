require "spec_helper"

describe AjaxController do
  describe "routing" do

    it "routes to Ajax#users" do
      get("/ajax/users").should route_to("ajax#users")
    end

  end
end
