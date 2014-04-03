require 'spec_helper'

describe "people/edit" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :name => "MyString",
      :email => "MyString",
      :password_digest => "MyString",
      :remember_token => "MyString"
    ))
  end

  it "renders the edit person form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", person_path(@person), "post" do
      assert_select "input#person_name[name=?]", "person[name]"
      assert_select "input#person_email[name=?]", "person[email]"
      assert_select "input#person_password_digest[name=?]", "person[password_digest]"
      assert_select "input#person_remember_token[name=?]", "person[remember_token]"
    end
  end
end
