require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }
    let(:local_lng) { I18n.default_locale }

    it  {should have_content('Log in')}    
    it  {should have_title(full_title('Log in'))}   
    it  {should have_content 'Email'}    
    it  {should have_field 'session_email'}    
    it  {should have_content 'Password'}    
    it  {should have_field 'session_password'}    
    it  {should have_button 'btn_log_in'}  
    
    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_title(full_title('Log in')) }
      it { should have_selector('div.alert.alert-error') }
    end
    
    describe "with valid information" do
      let(:person) { FactoryGirl.create(:person) }
      before do
        fill_in "session_email",    with: person.email.upcase
        fill_in "session_password", with: person.password
        click_button "btn_log_in"
      end
      
      it { should_not have_selector('div.alert.alert-error') }
      it { should have_title(full_title('List of Events')) }
      it { should have_link('Sign out',    href: signout_path(local_lng)) }
      it { should_not have_link('Sign in', href: signin_path(local_lng)) }
      it { should have_link('Actions') }
      it { should have_link('People list', href: people_path(local_lng)) }
      it { should have_link('New Person', href: new_person_path(local_lng)) }
      it { should have_link('List of Events', href: events_path(local_lng)) }
      it { should have_link('New Event', href: new_event_path(local_lng)) }
      it { should have_link('List of Events Types', href: event_types_path(local_lng)) }
      it { should have_link('New Event Type', href: new_event_type_path(local_lng)) }
            
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Log in') }
      end
    end
  end


  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:person) }

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_person_path(user) }
          it { should have_title(full_title('Log in')) }
          
          describe "visiting the person index" do
            before { visit people_path }
            it { should have_title(full_title('Log in')) }
          end
        end

        describe "submitting to the update action" do
          before { patch person_path(user) }
          specify { expect(response).to redirect_to(signin_path(:en)) }
        end
      end
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_person_path(user)
          fill_in "session_email",    with: user.email
          fill_in "session_password", with: user.password
          click_button "btn_log_in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_title(full_title('Editing Person Profile'))
          end
        end
      end
    end
   
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:person, admin:false) }
      let(:wrong_user) { FactoryGirl.create(:person, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Person#edit action" do
        before { get edit_person_path(wrong_user) }
        specify { expect(response.body).not_to match('Editing Person Profile') }
        specify { expect(response).to redirect_to(root_url(:en)) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch person_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url(:en)) }
      end
    end
 
 
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:person) }
      let(:non_admin) { FactoryGirl.create(:person, admin:false) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete person_path(user) }
        specify { expect(response).to redirect_to(root_url('en')) }
      end
    end
  end
  
end