require 'rails_helper'
require 'spec_helper'

I18n.default_locale = :en

describe "PaymentTypes" do   
  let(:lng) { I18n.default_locale }
  subject { page }
  
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in admin }
  
  describe "Payment Type creation" do
    before { visit new_payment_type_path }
    
    it { should have_content('New Payment Type') }
    it { should have_link('list_link_header', href: payment_types_path(lng)) }
    it { should have_link('save_link_header') }
    it { should have_selector "form label[for='payment_type_name']", text: "Name" }
    it {should have_field 'payment_type_name'}     
    it { should have_selector "form label[for='payment_type_frequency']", text: "Frequency" }
    it {should have_select 'payment_type_frequency'} 
    it { should have_selector "form label[for='payment_type_amount']", text: "Amount" }
    it {should have_field 'payment_type_amount'}     
    
    
    describe "with invalid information" do
      it "should not create a Payment Type" do
        page.find("#new_payment_type").submit_form!
        expect {click_link("Save")}.not_to change(PaymentType, :count)
      end

      describe "error messages" do
        before {page.find("#new_payment_type").submit_form!} 
        it { should have_content('error') }
      end
      
      describe "with empty frequency" do
        before { 
          fill_in 'payment_type_name', with: 'Payment Type Name' 
          expect {page.find("#new_payment_type").submit_form!}.not_to change(PaymentType, :count) 
        }        
        it { should have_selector('.alert-error') }
        it { should have_content('error') }
      end 
      
      describe "with empty name" do
        before {
          page.select 'General', :from => 'Frequency'
          expect {page.find("#new_payment_type").submit_form!}.not_to change(PaymentType, :count) 
        }        
        it { should have_selector('.alert-error') }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before do 
        fill_in 'payment_type_name', with: 'Payment Type Name' 
        page.select 'General', :from => 'Frequency'
      end
      
      it "should create a Payment Type" do
        expect { page.find("#new_payment_type").submit_form! }.to change(PaymentType, :count).by(1)
      end
    end
    
    describe "with name that alrady exists" do
      let(:pt1) {FactoryGirl.create(:payment_type, 
          name: 'PaymentType to test name that laready exists', frequency: 1)}
      before { 
        fill_in 'payment_type_name', with: pt1.name 
        page.select 'General', :from => 'Frequency'
      }
      
      it "should not create a Payment Type" do
        expect {page.find("#new_payment_type").submit_form!}.not_to change(PaymentType, :count)
      end

      describe "error messages" do
        before do
          page.find("#new_payment_type").submit_form!          
        end
        
        it { should have_selector('div.alert.alert-error') }
      end
    end
    
    #    describe "click list link should brings index page" do
    #      it do
    #        click_link("List")
    #        expect(page).to have_content 'List of Payment Types'
    #      end
    #    end
    #    
    #    describe "click Save link should brings error" do
    #      it do
    #        click_link_or_button("list_link_header")
    #      end
    #    end
    
  end
  
  
  describe "index" do
    before(:each) do
      visit payment_types_path
    end

    it { should have_title(full_title('List of Payment Types')) }
    it { should have_content('List of Payment Types') }
    it { should have_link('new_link_header', href: new_payment_type_path(lng)) }

    describe "should list all Payment Types" do
      before(:all) { 30.times { FactoryGirl.create(:payment_type,
            frequency: 1) } }
      after(:all)  { PaymentType.delete_all }

      it "should list each Payment Type" do
        PaymentType.all.each do |item|
          expect(page).to have_selector('a', text: item.name)
        end
      end
    end
  end 
  

  describe "Editing Payment Type" do     
    let(:pt1) {FactoryGirl.create(:payment_type, frequency: 1)}
    before {visit edit_payment_type_path(pt1)}
     
    it { should have_content('Editing Payment Type') }
    it { should have_link('list_link_header', href: payment_types_path(lng)) }
    it { should have_link('new_link_header', href: new_payment_type_path(lng)) }
    it { should have_link('delete_link_header', href: payment_type_path(lng, pt1)) }
    it { should have_link('save_link_header') }
    it { should have_selector "form label[for='payment_type_name']", text: "Name" }
    it {should have_field 'payment_type_name'}    
    it { should have_selector "form label[for='payment_type_frequency']", text: "Frequency" }
    it {should have_select 'payment_type_frequency'} 
    it { should have_selector "form label[for='payment_type_amount']", text: "Amount" }
    it {should have_field 'payment_type_amount'}     
    
    describe "with invalid information" do
      before do
        page.find("#edit_payment_type_#{pt1.id}").submit_form!          
      end
      it { should have_content("Editing Payment Type") }
       
      describe "with empty name" do
        before { 
          fill_in 'payment_type_name', with: '' 
          page.find("#edit_payment_type_#{pt1.id}").submit_form! 
        }        
        it { should have_selector('.alert-error') }
        it { should have_content('error') }
      end
      
      describe "with empty code" do
        before { 
          page.select '', :from => 'Frequency'
          page.find("#edit_payment_type_#{pt1.id}").submit_form! 
        }        
        it { should have_selector('.alert-error') }
        it { should have_content('error') }
      end  
      
      describe "with name that alrady exists" do
        let(:pt2) {FactoryGirl.create(:payment_type, frequency: 1)}
        before { 
          fill_in 'payment_type_name', with: pt2.name 
        }

        it "should not create a Payment Type" do
          expect { page.find("#edit_payment_type_#{pt1.id}").submit_form!}.not_to change(PaymentType, :count)
        end

        describe "error messages" do
          before do
            page.find("#edit_payment_type_#{pt1.id}").submit_form!         
          end

          it { should have_selector('div.alert.alert-error') }
        end
      end
    end
  
  end
  
  describe "Payment Type destruction" do      
    let(:pt1) {FactoryGirl.create(:payment_type, frequency: 1)}
    before {visit edit_payment_type_path(pt1)}
    it { should have_link('delete_link_header', href: payment_type_path('en', pt1)) }
    
    it "should delete a Payment Type" do
      expect { click_link('delete_link_header') }.to change(PaymentType, :count).by(-1)
    end
  end
  
  #  describe "language destruction that in use by person" do      
  #    let(:lng1) {FactoryGirl.create(:language, 
  #      name: 'Language that in use by person to test destroy', code: 'ad')}
  #    let!(:person1) {FactoryGirl.create(:person)}
  #    before {
  #      person1.add_language!(lng1)
  #      visit edit_language_path(lng1)
  #    }
  #        
  #    it "should not delete a role" do
  #      expect { click_link('delete_link_header') }.not_to change(Language, :count)
  #    end
  #    
  #    describe "error messages" do
  #      before {click_link('delete_link_header')} 
  #      it { should have_selector('div.alert.alert-error') }
  #    end
  #   
  #  end  
end
  
#end
