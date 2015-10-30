require 'rails_helper'
require 'spec_helper'

describe "Events" do  
  subject { page }
  let(:lng) { I18n.default_locale }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:event_type) {FactoryGirl.create(:event_type)}
  before {sign_in admin}
  
  describe "index" do
    let(:event_type) {FactoryGirl.create(:event_type)}
    let(:event) {FactoryGirl.create(:event, event_type:event_type)}
    
    it "describe index page"
  end
      
  describe "Editing Event" do
    let!(:event) {FactoryGirl.create(:event, event_type:event_type)}
    let!(:p1) {FactoryGirl.create(:person, admin: false)}
    let!(:p2) {FactoryGirl.create(:person, admin: false)}
    let!(:r1) {FactoryGirl.create(:person_event_relationship, event: event, person: p1)}
    let!(:r2) {FactoryGirl.create(:person_event_relationship, event: event, person: p2)}
    
    before { visit edit_event_path(event) }
    
    it { should have_content('Editing Event') }
    it { should have_link('list_link_header', href: events_path(lng)) }
    it { should have_link('new_link_header', href: new_event_path(lng)) }
    it { should have_link('delete_link_header', href: event_path(lng,event)) }
    it { should have_link('save_link_header') }
    it { should have_content(event_type.name) }
    it { should have_content(p1.name) }
    it { should have_content(p2.name) }
    it { should have_content(admin.name) }
    it { should have_xpath("//td[@id='td_present_person_#{p1.id}']/img[@alt='Vicon']")}
    it { should have_xpath("//td[@id='td_present_person_#{p2.id}']/img[@alt='Vicon']")}
    it { should_not have_xpath("//td[@id='td_present_person_#{admin.id}']/img[@alt='Vicon']")}
    
    it "people pagination"
    it "should add person to even"
    it "should remove person from even"
        
  end
  
  
  describe "event creation" do
    let!(:et2) {FactoryGirl.create(:event_type, name:'event type 2')}
    before { visit new_event_path }

    describe "with valid information" do
      before do 
        fill_in 'event_event_date', with: Date.today
        select et2.name, :from => 'event_event_type_id'
        fill_in 'event_description', with: 'Event descr'
      end
      
      it "should create a event" do
        expect {page.find("#new_event").submit_form!}.to change(Event, :count)
      end

      describe "should not have error messages" do
        before {page.find("#new_event").submit_form!} 
        it { should_not have_content('error') }
      end
    end
    
    describe "with invalid information" do
      before {et2.destroy}
      
      it "should not create a event" do
        expect {page.find("#new_event").submit_form!}.not_to change(Event, :count)
      end

      describe "error messages" do
        before {page.find("#new_event").submit_form!} 
        it { should have_content('error') }
      end
    end

  end
end
