require 'spec_helper'

describe EventType do      
  before  do
    @event_type = EventType.new(name: "Event Type For Test 1")
  end 
  subject { @event_type }
  it { should be_valid }
  
  describe "Event Type attributes" do
    it { should respond_to(:name) }  
  end
   
  describe "Event Type relations" do
    it { should respond_to(:events) }  
  end
  
  describe "When Event Type Name is not present" do
    before { @event_type.name = nil }
    it { should_not be_valid }    
  end
    
  describe "When Event Type Name is to long" do
    before { @event_type.name = "a" * 61 }
    it { should_not be_valid }    
  end
  
  describe "when event name is already taken" do    
    before do
      event_type_with_same_name = @event_type.dup
      event_type_with_same_name.name = @event_type.name.upcase
      event_type_with_same_name.save
    end
    it { should_not be_valid }
  end
  
  describe "when event type is already in use by event" do
    let(:event_type) { EventType.create!(name: DateTime.now) }
    before do
      event = event_type.events.create!(
        description: "Event For test delete event type #{event_type.name}")        
    end
    it "should not delete a event type" do
      expect { event_type.destroy }.not_to change(EventType, :count)
    end          
  end
end
