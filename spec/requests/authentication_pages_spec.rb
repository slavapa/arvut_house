require 'spec_helper'

I18n.default_locale = :en

describe "Authentication" do
  let(:lng) { I18n.default_locale }
  subject { page }
    
  before do     
    @event_type = FactoryGirl.create(:event_type) 
    @event = @event_type.events.new(description: 'Event Descr For Test Authentication')  
  end

  describe "signin page" do
    before { visit signin_path }

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
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        fill_in "session_email",    with: admin.email.upcase
        fill_in "session_password", with: admin.password
        click_button "btn_log_in"
      end
      
      it { should_not have_selector('div.alert.alert-error') }
      it { should have_title(full_title('List of Events')) }
      it { should have_link('Sign out',    href: signout_path(lng)) }
      it { should_not have_link('Sign in', href: signin_path(lng)) }
      it { should have_link('Actions') }
      it { should have_link('People list', href: people_path(lng)) }
      it { should have_link('New Person', href: new_person_path(lng)) }
      it { should have_link('List of Events', href: events_path(lng)) }
      it { should have_link('New Event', href: new_event_path(lng)) }
      it { should have_link('List of Events Types', href: event_types_path(lng)) }
      it { should have_link('New Event Type', href: new_event_type_path(lng)) }
            
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
      let(:admin) { FactoryGirl.create(:admin) }

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_person_path(admin) }
          it { should have_title(full_title('Log in')) }
          
          describe "visiting the person index" do
            before { visit people_path }
            it { should have_title(full_title('Log in')) }
          end
        end

        describe "submitting to the update action" do
          before { patch person_path(admin) }
          specify { expect(response).to redirect_to(signin_path(:en)) }
        end
      end
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_person_path(admin)
          fill_in "session_email",    with: admin.email
          fill_in "session_password", with: admin.password
          click_button "btn_log_in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_title(full_title('Editing Person Profile'))
          end
        end
      end
    
    
      describe "in the Events controller" do
        describe "submitting to the create action" do
          before { post events_path }
          specify { expect(response).to redirect_to(signin_path(lng)) }
        end

        describe "submitting to the destroy action" do
          let(:event_type) {FactoryGirl.create(:event_type)}
          let(:event) {FactoryGirl.create(:event, event_type:event_type)}
          before {delete event_path(event) }
          specify { expect(response).to redirect_to(signin_path(lng)) }
        end
      end
      
      describe "in the Event Type controller" do
        describe "submitting to the create action" do
          before { post event_types_path }
          specify { expect(response).to redirect_to(signin_path(lng)) }
        end

        describe "submitting to the destroy action" do
          let(:event_type) {FactoryGirl.create(:event_type)}
          before {delete event_type_path(event_type)} 
          specify { expect(response).to redirect_to(signin_path(lng)) }
        end
      end
      
      describe "in the People controller" do
        describe "submitting to the create action" do
          before { post people_path }
          specify { expect(response).to redirect_to(signin_path(lng)) }
        end

        describe "submitting to the destroy action" do
          let(:person) {FactoryGirl.create(:person, admin:false)}
          before {delete person_path(person) } 
          specify { expect(response).to redirect_to(signin_path(lng)) }
        end
      end
      
    end
   
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:person, admin:false) }
      let(:wrong_user) { FactoryGirl.create(:admin, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Person#edit action" do
        # before { get edit_person_path(wrong_user) }
        # specify { expect(response.body).not_to match('Editing Person Profile') }
        # specify { expect(response).to redirect_to(root_url(lng)) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        # before { patch person_path(wrong_user) }
        # specify { expect(response).to redirect_to(root_url(lng)) }
      end
    end
 
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:person, admin:false) }
      let(:non_admin) { FactoryGirl.create(:person, admin:false) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete person_path(user) }
        specify { expect(response).to redirect_to(root_url(lng)) }
      end
    end
  end
  
end