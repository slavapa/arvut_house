require 'rails_helper'
require 'spec_helper'

I18n.default_locale = :en

describe "Payments" do     
  let(:ptp1) {FactoryGirl.create(:payment_type, frequency: 1, name:'ptp1')}
  let(:lng) { I18n.default_locale }
  subject { page }
  
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in admin }
  
  describe "role creation" do
    before do
      ptp1.save
      visit new_payment_path 
    end
    
    it { should have_content('New Payment') }
    it { should have_link('list_link_header', href: payments_path(lng)) }
    it { should have_link('save_link_header') }
    
    it { should have_selector "form label[for='payment_event_date']", text: "Payment date" }
    it {should have_field 'payment_payment_date'} 
    
    it { should have_selector "form label[for='payment_event_type_id']", text: "Payment Type" }
#    it {should have_select 'payment_payment_type_id'}
    it {have_selector("input", :type => "date", :name => "payment[payment_date]",
                                     :value => Date.today)}
    
    it { should have_selector "form label[for='payment_description']", text: "Description" }
    it {should have_field 'payment_description'}
    
#    describe "with valid information" do
#      before do 
##        fill_in 'payment_type_name', with: 'Payment Type Name' 
##        page.select 'General', :from => 'Frequency'
#      end
#      
#      it "should create a Payment" do
#        expect { page.find("#new_payment").submit_form! }.to change(Payment, :count).by(1)
#      end
#    end
    
#    describe "with invalid information" do
#      it "should not create a role" do
#        expect {page.find("#new_payment").submit_form!}.to change(Payment, :count)
#      end
#
#      describe "error messages" do
#        before {page.find("#new_payment").submit_form!} 
#        it { should have_content('error') }
#      end
#    end
    
    describe "with valid information" do
#      before { fill_in 'role_name', with: "Role Test" }
      it "should create a role" do
        expect { page.find("#new_payment").submit_form! }.to change(Payment, :count)
      end
    end
    
#    describe "with name that alrady exists" do
#      let(:role1) {FactoryGirl.create(:role, name: 'Role to test name that laready exists')}
#      before { fill_in 'role_name', with: role1.name }
#      it "should not create a role" do
#        expect {page.find("#new_role").submit_form!}.not_to change(Role, :count)
#      end
#
#      describe "error messages" do
#        before {page.find("#new_role").submit_form!} 
#        it { should have_selector('div.alert.alert-error') }
#      end
#    end
    
  end
  
  
end
