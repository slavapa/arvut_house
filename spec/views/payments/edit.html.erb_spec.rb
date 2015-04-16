#require 'spec_helper'
#
#describe "payments/edit" do
#  before(:each) do
#    @payment = assign(:payment, stub_model(Payment,
#      :description => "MyString",
#      :payment_type => nil
#    ))
#  end
#
#  it "renders the edit payment form" do
#    render
#
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "form[action=?][method=?]", payment_path(@payment), "post" do
#      assert_select "input#payment_description[name=?]", "payment[description]"
#      assert_select "input#payment_payment_type[name=?]", "payment[payment_type]"
#    end
#  end
#end
