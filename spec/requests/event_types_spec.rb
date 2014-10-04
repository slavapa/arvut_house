require 'spec_helper'

I18n.default_locale = :en

describe "EventTypes" do
  let(:lng) { I18n.default_locale }
  subject { page }
  
  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in admin }

  describe "event type creation" do
    before { visit new_event_type_path }
    
    it { should have_content('New Event Type') }
    it { should have_link('list_link_header', href: event_types_path(lng)) }
    it { should have_link('save_link_header') }
    it { should have_selector "form label[for='event_type_name']", text: "Name" }
    it {should have_field 'event_type_name'} 
    

    describe "with invalid information" do
      it "should not create a event type" do
        expect {page.find("#new_event_type").submit_form!}.not_to change(EventType, :count)
      end

      describe "error messages" do
        before {page.find("#new_event_type").submit_form!} 
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'event_type_name', with: "Event Type For Test" }
      it "should create a event type" do
        expect { page.find("#new_event_type").submit_form! }.to change(EventType, :count).by(1)
      end
    end
    
    
    describe "with name that alrady exists" do
      let(:et1) {FactoryGirl.create(:event_type, name: 'ET to test name that laready exists')}
      before { fill_in 'event_type_name', with: et1.name }
      it "should not create a event type" do
        expect {page.find("#new_event_type").submit_form!}.not_to change(EventType, :count)
      end

      describe "error messages" do
        before {page.find("#new_event_type").submit_form!} 
        it { should have_selector('div.alert.alert-error') }
      end
    end
  end
  
  describe "Editing Event Type" do     
    let(:et1) {FactoryGirl.create(:event_type, name: 'ET to test editng page')}
    before {visit edit_event_type_path(et1)}
     
    it { should have_content('Editing event Type') }
    it { should have_link('list_link_header', href: event_types_path(lng)) }
    it { should have_link('new_link_header', href: new_event_type_path(lng)) }
    it { should have_link('delete_link_header', href: event_type_path(lng, et1)) }
    it { should have_link('save_link_header') }
    it { should have_selector "form label[for='event_type_name']", text: "Name" }
    it {should have_field 'event_type_name'} 
    
    describe "with invalid information" do
      before do
        fill_in "event_type_name",    with: ''
        page.find("#edit_event_type_#{et1.id}").submit_form!          
      end
      it { should have_content("Editing event Type") }
      it { should have_selector('.alert-error') }
      it { should have_content('error') }
    end
  end
  
  
  describe "event type destruction" do      
    let(:et1) {FactoryGirl.create(:event_type, name: 'Event Type to test destroy')}
    before {visit edit_event_type_path(et1)}
    it { should have_link('delete_link_header', href: event_type_path('en', et1)) }
    
    it "should delete a event_type" do
      expect { click_link('delete_link_header') }.to change(EventType, :count).by(-1)
    end
  end
  
  describe "event type destruction that in use by event" do      
    let(:et1) {FactoryGirl.create(:event_type, name: 'ET that in use by event to test destroy')}
    let!(:ev1) {FactoryGirl.create(:event, event_type: et1)}
    before {visit edit_event_type_path(et1)}
        
    it "should not delete a event_type" do
      expect { click_link('delete_link_header') }.not_to change(EventType, :count)
    end
    
    describe "error messages" do
      before {click_link('delete_link_header')} 
      it { should have_selector('div.alert.alert-error') }
    end
   
  end
  
  it "describe index page"
  it "describe editing page"
end
