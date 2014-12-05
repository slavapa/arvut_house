require 'spec_helper'

describe "paymet_types/edit" do
  before(:each) do
    @paymet_type = assign(:paymet_type, stub_model(PaymetType,
      :name => "MyString",
      :frequency => 1
    ))
  end

  it "renders the edit paymet_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", paymet_type_path(@paymet_type), "post" do
      assert_select "input#paymet_type_name[name=?]", "paymet_type[name]"
      assert_select "input#paymet_type_frequency[name=?]", "paymet_type[frequency]"
    end
  end
end
