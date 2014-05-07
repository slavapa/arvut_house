require 'spec_helper'

describe PersonEventRelationship do
  let(:person) { FactoryGirl.create(:person, admin: false) }
  let(:event_type) {FactoryGirl.create(:event_type)}
  let(:event) {event_type.events.create(description: 'Event Descr For Test Event 2')}
  before do
    @person_event_relationship = event.person_event_relationships.build(person_id: person.id)
  end  
  
  subject { @person_event_relationship } 
  
  it { should be_valid }
  its(:person) { should eq person }
  its(:event) { should eq event }
  
  
  describe "event type relation" do
    before { @person_event_relationship.save}
    its(:event_type) { should eq event_type }    
  end
  
  describe "person_event_relationships attributes" do 
    it { should respond_to(:person_id) }
    it { should respond_to(:event_id) }
  end
   
  describe "person_event_relationships relations" do
    it { should respond_to(:event) }  
    it { should respond_to(:person) } 
    it { should respond_to(:event_type) }
  end 
  
  describe "when person_id is not present" do
    before { @person_event_relationship.person_id = nil }
    it { should_not be_valid }
  end
  
  describe "when event_id is not present" do
    before { @person_event_relationship.event_id = nil }
    it { should_not be_valid }
  end
  
end
