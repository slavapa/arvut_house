require 'spec_helper'

describe "paymet_types/index" do
  before(:each) do
    assign(:paymet_types, [
      stub_model(PaymetType,
        :name => "Name",
        :frequency => 1
      ),
      stub_model(PaymetType,
        :name => "Name",
        :frequency => 1
      )
    ])
  end

  it "renders a list of paymet_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
