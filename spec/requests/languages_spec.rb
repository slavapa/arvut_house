require 'spec_helper'

I18n.default_locale = :en

describe "Languages" do  
  let(:lng) { I18n.default_locale }
  subject { page }
  
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in admin }
  
  describe "language creation" do
    before { visit new_language_path }
    
    it { should have_content('New Language') }
    it { should have_link('list_link_header', href: languages_path(lng)) }
    it { should have_link('save_link_header') }
    it { should have_selector "form label[for='language_name']", text: "Name" }
    it {should have_field 'language_name'} 
    
    describe "with invalid information" do
      it "should not create a language" do
        expect {page.find("#new_language").submit_form!}.not_to change(Language, :count)
      end

      describe "error messages" do
        before {page.find("#new_language").submit_form!} 
        it { should have_content('error') }
      end
      
      describe "with empty name" do
        before { 
          fill_in 'language_code', with: 'ab' 
          expect {page.find("#new_language").submit_form!}.not_to change(Language, :count) 
        }        
        it { should have_selector('.alert-error') }
        it { should have_content('error') }
      end
      
      describe "with empty code" do
        before { 
          fill_in 'language_name', with: 'Language 1'
          expect {page.find("#new_language").submit_form!}.not_to change(Language, :count) 
        }        
        it { should have_selector('.alert-error') }
        it { should have_content('error') }
      end    
    end
    
    describe "with valid information" do
      before { 
        fill_in 'language_name', with: "Language Test" 
        fill_in 'language_code', with: "lt"
      }
      it "should create a role" do
        expect { page.find("#new_language").submit_form! }.to change(Language, :count).by(1)
      end
    end
    
    describe "with name that alrady exists" do
      let(:lng1) {FactoryGirl.create(:language, 
        name: 'Language to test name that laready exists', code: 'ln')}
      before { 
        fill_in 'language_name', with: lng1.name 
        fill_in 'language_code', with: lng1.code 
      }
      
      it "should not create a role" do
        expect {page.find("#new_language").submit_form!}.not_to change(Language, :count)
      end

      describe "error messages" do
        before {page.find("#new_language").submit_form!} 
        it { should have_selector('div.alert.alert-error') }
      end
    end
    
  end
  
  describe "Editing Language" do     
    let(:lng1) {FactoryGirl.create(:language, name: 'Language 1', code: 'aa')}
    before {visit edit_language_path(lng1)}
     
    it { should have_content('Editing Language') }
    it { should have_link('list_link_header', href: languages_path(lng)) }
    it { should have_link('new_link_header', href: new_language_path(lng)) }
    it { should have_link('delete_link_header', href: language_path(lng, lng1)) }
    it { should have_link('save_link_header') }
    it { should have_selector "form label[for='language_name']", text: "Name" }
    it {should have_field 'language_name'} 
    it { should have_selector "form label[for='language_code']", text: "Code" }
    it {should have_field 'language_code'} 
    
    describe "with invalid information" do
      before do
        page.find("#edit_language_#{lng1.id}").submit_form!          
      end
      it { should have_content("Editing Language") }
       
      describe "with empty name" do
        before { 
          fill_in 'language_name', with: '' 
          page.find("#edit_language_#{lng1.id}").submit_form! 
        }        
        it { should have_selector('.alert-error') }
        it { should have_content('error') }
      end
      
      describe "with empty code" do
        before { 
          fill_in 'language_code', with: ''
          page.find("#edit_language_#{lng1.id}").submit_form! 
        }        
        it { should have_selector('.alert-error') }
        it { should have_content('error') }
      end    
    end
  
  end
  
  describe "Language destruction" do      
    let(:lng1) {FactoryGirl.create(:language, name: 'Language to test destroy', code: 'ac')}
    before {visit edit_language_path(lng1)}
    it { should have_link('delete_link_header', href: language_path('en', lng1)) }
    
    it "should delete a language" do
      expect { click_link('delete_link_header') }.to change(Language, :count).by(-1)
    end
  end
  
  describe "language destruction that in use by person" do      
    let(:lng1) {FactoryGirl.create(:language, 
      name: 'Language that in use by person to test destroy', code: 'ad')}
    let!(:person1) {FactoryGirl.create(:person)}
    before {
      person1.add_language!(lng1)
      visit edit_language_path(lng1)
    }
        
    it "should not delete a role" do
      expect { click_link('delete_link_header') }.not_to change(Language, :count)
    end
    
    describe "error messages" do
      before {click_link('delete_link_header')} 
      it { should have_selector('div.alert.alert-error') }
    end
   
  end
  
  
  describe "index" do
    before(:each) do
      visit languages_path
    end

    it { should have_title(full_title('List of Language')) }
    it { should have_content('List of Language') } 
    it { should have_link('new_link_header', href: new_language_path(lng)) }

    describe "should list all languages" do
      before(:all) {
        firstCharCode = 'a'.ord
        secondCharCode = 'a'.ord 
        30.times do |i|
          if secondCharCode > 'z'.ord
            secondCharCode = 'a'.ord
            firstCharCode +=1
          end
          
          if firstCharCode > 'z'.ord
            firstCharCode = 'a'.ord
          end
          
          lngName = "Language #{i}"
          lngCode = firstCharCode.chr + secondCharCode.chr
          FactoryGirl.create(:language, name: lngName, code: lngCode)
          secondCharCode +=1           
        end
      }
      after(:all)  { Language.delete_all }

      it "should list each language" do
        Language.all.each do |item|
          expect(page).to have_selector('a', text: item.name)     
        end
      end
     
    end
    
  end
end
