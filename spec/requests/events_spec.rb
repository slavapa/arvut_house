require 'spec_helper'

describe "Events" do
  describe "index" do
    let(:event_type) {FactoryGirl.create(:event_type)}
    let(:event) {FactoryGirl.create(:event, event_type:event_type)}
    
    it "describe index page"
  end
  
  it "describe new page"
  
  describe "Editing Event" do
    let!(:event_type) {FactoryGirl.create(:event_type)}
    let!(:event) {FactoryGirl.create(:event, event_type:event_type)}
    let!(:p1) {FactoryGirl.create(:person, admin: false)}
    let!(:p2) {FactoryGirl.create(:person, admin: false)}
    let!(:r1) {FactoryGirl.create(:person_event_relationship, event: event, person: p1)}
    let!(:r2) {FactoryGirl.create(:person_event_relationship, event: event, person: p2)}
    
    before { visit edit_event_path(event) }
    
    it "have_content('Editing Event')" # { should have_content('Editing Event') }
        
  end
end
