require 'spec_helper'

describe "department_person_roles/show" do
  before(:each) do
    @department_person_role = assign(:department_person_role, stub_model(DepartmentPersonRole,
      :department => nil,
      :person => nil,
      :role => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
