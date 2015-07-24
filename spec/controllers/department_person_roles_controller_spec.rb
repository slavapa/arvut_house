require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe DepartmentPersonRolesController do

  # This should return the minimal set of attributes required to create a valid
  # DepartmentPersonRole. As you add validations to DepartmentPersonRole, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "department" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DepartmentPersonRolesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all department_person_roles as @department_person_roles" do
      department_person_role = DepartmentPersonRole.create! valid_attributes
      get :index, {}, valid_session
      assigns(:department_person_roles).should eq([department_person_role])
    end
  end

  describe "GET show" do
    it "assigns the requested department_person_role as @department_person_role" do
      department_person_role = DepartmentPersonRole.create! valid_attributes
      get :show, {:id => department_person_role.to_param}, valid_session
      assigns(:department_person_role).should eq(department_person_role)
    end
  end

  describe "GET new" do
    it "assigns a new department_person_role as @department_person_role" do
      get :new, {}, valid_session
      assigns(:department_person_role).should be_a_new(DepartmentPersonRole)
    end
  end

  describe "GET edit" do
    it "assigns the requested department_person_role as @department_person_role" do
      department_person_role = DepartmentPersonRole.create! valid_attributes
      get :edit, {:id => department_person_role.to_param}, valid_session
      assigns(:department_person_role).should eq(department_person_role)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new DepartmentPersonRole" do
        expect {
          post :create, {:department_person_role => valid_attributes}, valid_session
        }.to change(DepartmentPersonRole, :count).by(1)
      end

      it "assigns a newly created department_person_role as @department_person_role" do
        post :create, {:department_person_role => valid_attributes}, valid_session
        assigns(:department_person_role).should be_a(DepartmentPersonRole)
        assigns(:department_person_role).should be_persisted
      end

      it "redirects to the created department_person_role" do
        post :create, {:department_person_role => valid_attributes}, valid_session
        response.should redirect_to(DepartmentPersonRole.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved department_person_role as @department_person_role" do
        # Trigger the behavior that occurs when invalid params are submitted
        DepartmentPersonRole.any_instance.stub(:save).and_return(false)
        post :create, {:department_person_role => { "department" => "invalid value" }}, valid_session
        assigns(:department_person_role).should be_a_new(DepartmentPersonRole)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        DepartmentPersonRole.any_instance.stub(:save).and_return(false)
        post :create, {:department_person_role => { "department" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested department_person_role" do
        department_person_role = DepartmentPersonRole.create! valid_attributes
        # Assuming there are no other department_person_roles in the database, this
        # specifies that the DepartmentPersonRole created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        DepartmentPersonRole.any_instance.should_receive(:update).with({ "department" => "" })
        put :update, {:id => department_person_role.to_param, :department_person_role => { "department" => "" }}, valid_session
      end

      it "assigns the requested department_person_role as @department_person_role" do
        department_person_role = DepartmentPersonRole.create! valid_attributes
        put :update, {:id => department_person_role.to_param, :department_person_role => valid_attributes}, valid_session
        assigns(:department_person_role).should eq(department_person_role)
      end

      it "redirects to the department_person_role" do
        department_person_role = DepartmentPersonRole.create! valid_attributes
        put :update, {:id => department_person_role.to_param, :department_person_role => valid_attributes}, valid_session
        response.should redirect_to(department_person_role)
      end
    end

    describe "with invalid params" do
      it "assigns the department_person_role as @department_person_role" do
        department_person_role = DepartmentPersonRole.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DepartmentPersonRole.any_instance.stub(:save).and_return(false)
        put :update, {:id => department_person_role.to_param, :department_person_role => { "department" => "invalid value" }}, valid_session
        assigns(:department_person_role).should eq(department_person_role)
      end

      it "re-renders the 'edit' template" do
        department_person_role = DepartmentPersonRole.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DepartmentPersonRole.any_instance.stub(:save).and_return(false)
        put :update, {:id => department_person_role.to_param, :department_person_role => { "department" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested department_person_role" do
      department_person_role = DepartmentPersonRole.create! valid_attributes
      expect {
        delete :destroy, {:id => department_person_role.to_param}, valid_session
      }.to change(DepartmentPersonRole, :count).by(-1)
    end

    it "redirects to the department_person_roles list" do
      department_person_role = DepartmentPersonRole.create! valid_attributes
      delete :destroy, {:id => department_person_role.to_param}, valid_session
      response.should redirect_to(department_person_roles_url)
    end
  end

end
