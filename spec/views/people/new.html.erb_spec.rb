require 'spec_helper'

describe "people/new" do
  before(:each) do
    assign(:person, stub_model(Person,
      :name => "MyString",
      :email => "MyString",
      :password_digest => "MyString",
      :remember_token => "MyString"
    ).as_new_record)
  end

  it "renders new person form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", people_path, "post" do
      assert_select "input#person_name[name=?]", "person[name]"
      assert_select "input#person_email[name=?]", "person[email]"
      assert_select "input#person_password_digest[name=?]", "person[password_digest]"
      assert_select "input#person_remember_token[name=?]", "person[remember_token]"
    end
  end
end
