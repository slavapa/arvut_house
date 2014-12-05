require 'spec_helper'

describe "paymet_types/new" do
  before(:each) do
    assign(:paymet_type, stub_model(PaymetType,
      :name => "MyString",
      :frequency => 1
    ).as_new_record)
  end

  it "renders new paymet_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", paymet_types_path, "post" do
      assert_select "input#paymet_type_name[name=?]", "paymet_type[name]"
      assert_select "input#paymet_type_frequency[name=?]", "paymet_type[frequency]"
    end
  end
end
