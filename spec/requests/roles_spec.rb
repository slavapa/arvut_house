require 'spec_helper'

I18n.default_locale = :en

describe "Roles" do
  let(:lng) { I18n.default_locale }
  subject { page }
  
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in admin }
  
  describe "role creation" do
    before { visit new_role_path }
    
    it { should have_content('New Role') }
    it { should have_link('list_link_header', href: roles_path(lng)) }
    it { should have_link('save_link_header') }
    it { should have_selector "form label[for='role_name']", text: "Name" }
    it {should have_field 'role_name'} 
    
    describe "with invalid information" do
      it "should not create a role" do
        expect {page.find("#new_role").submit_form!}.not_to change(Role, :count)
      end

      describe "error messages" do
        before {page.find("#new_role").submit_form!} 
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before { fill_in 'role_name', with: "Role Test" }
      it "should create a role" do
        expect { page.find("#new_role").submit_form! }.to change(Role, :count).by(1)
      end
    end
    
    describe "with name that alrady exists" do
      let(:role1) {FactoryGirl.create(:role, name: 'Role to test name that laready exists')}
      before { fill_in 'role_name', with: role1.name }
      it "should not create a role" do
        expect {page.find("#new_role").submit_form!}.not_to change(Role, :count)
      end

      describe "error messages" do
        before {page.find("#new_role").submit_form!} 
        it { should have_selector('div.alert.alert-error') }
      end
    end
    
  end
 
  describe "Editing Role" do     
    let(:role1) {FactoryGirl.create(:role, name: 'Role to test editng page')}
    before {visit edit_role_path(role1)}
     
    it { should have_content('Editing Role') }
    it { should have_link('list_link_header', href: roles_path(lng)) }
    it { should have_link('new_link_header', href: new_role_path(lng)) }
    it { should have_link('delete_link_header', href: role_path(lng, role1)) }
    it { should have_link('save_link_header') }
    it { should have_selector "form label[for='role_name']", text: "Name" }
    it {should have_field 'role_name'} 
    
    describe "with invalid information" do
      before do
        fill_in "role_name",    with: ''
        page.find("#edit_role_#{role1.id}").submit_form!          
      end
      it { should have_content("Editing Role") }
      it { should have_selector('.alert-error') }
      it { should have_content('error') }
    end
  end

  describe "role destruction" do      
    let(:role1) {FactoryGirl.create(:role, name: 'Role to test destroy')}
    before {visit edit_role_path(role1)}
    it { should have_link('delete_link_header', href: role_path('en', role1)) }
    
    it "should delete a role" do
      expect { click_link('delete_link_header') }.to change(Role, :count).by(-1)
    end
  end
  
  # describe "roles destruction that in use by person" do      
  #   let(:role1) {FactoryGirl.create(:role, name: 'Role that in use by person to test destroy')}
  #   let!(:person1) {FactoryGirl.create(:person)}
  #   before {
  #     person1.add_role!(role1)
  #     visit edit_role_path(role1)
  #   }
        
  #   it "should not delete a role" do
  #     expect { click_link('delete_link_header') }.not_to change(Role, :count)
  #   end
    
  #   describe "error messages" do
  #     before {click_link('delete_link_header')} 
  #     it { should have_selector('div.alert.alert-error') }
  #   end   
  # end
  
  describe "index" do
    before(:each) do
      visit roles_path
    end

    it { should have_title(full_title('List of Roles')) }
    it { should have_content('List of Roles') }
    it { should have_link('new_link_header', href: new_role_path(lng)) }

    describe "should list all roles" do
      before(:all) { 30.times { FactoryGirl.create(:role) } }
      after(:all)  { Role.delete_all }


      it "should list each role" do
        Role.all.each do |item|
          expect(page).to have_selector('a', text: item.name)
        end
      end
    end
  end 
  
end
