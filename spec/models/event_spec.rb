require 'spec_helper'

describe Event do  
  before { 
    @event_type = EventType.create(name: 'Event Type For Test Event 2')
    @person = Person.create(name: "First Person For Test", 
      email: "first_person@test.com")
    @event = @event_type.events.new(description: 'Event Descr For Test Event 2')    
  }
              
  subject { @event }  
  
  describe "event attributes" do 
    it { should respond_to(:event_date) }
    it { should respond_to(:description) }
    it { should respond_to(:event_type_id) }
  end
  
  describe "person relations" do
    it { should respond_to(:event_types) }  
    it { should respond_to(:people) } 
    it { should respond_to(:person_event_relationships) }
  end 
  
  describe "when event is valid" do
    before { @event.save }
    it { should be_valid }
  end
  
  describe "when event tpe id is not present" do
    before { @event.event_type_id = nil }
    it { should_not be_valid }    
  end
  
  describe "when event date is not present" do
    before { @event.event_date = nil }
    it { should_not be_valid }    
  end
  
  describe "when event type id is not valid" do
    before do
      @event.event_type_id = -1
    end
    it { should_not be_valid }    
  end
    
  describe "event type id and event date is already taken" do
    before do
      event_with_same_data = @event.dup
      event_with_same_data.save
    end
    it { should_not be_valid }
  end
  
  describe "people associations through person_event_relationships" do
    before do
      @event.add_person!(@person)
      @event.save
      second_person = Person.create(name: "Second Person For Test", 
                      email: "second_person@test.com")  
      third_person = Person.create(name: "Third Person For Test", 
                      email: "third_person@test.com")    
    end     
    
    # it "should not delete a event type" do
      # expect { @event.is_perosn_exists?(@person) }.to be_true
    # end      
  end
  
end
