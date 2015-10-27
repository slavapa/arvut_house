require "rails_helper"

describe AjaxController do
  describe "routing", :type => :routing do

    it "routes to Ajax#users" do
      get("/ajax/users").should route_to("ajax#users")
      #get("/ajax/users").should route_to(controller: 'ajax', action: 'users')
      #get("/ajax/users").should route_to(controller: 'ajax', action: 'users')
      #expect(:get => "/ajax/users").not_to be_routable
      #expect(:get => "/ajax/users").to route_to(:controller => "ajax", :action => "users")
      #expect(get("/ajax/users")).to route_to(controller: 'ajax', action: 'users')
    end

  end
end
