require 'spec_helper'

describe "paymet_types/show" do
  before(:each) do
    @paymet_type = assign(:paymet_type, stub_model(PaymetType,
      :name => "Name",
      :frequency => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
