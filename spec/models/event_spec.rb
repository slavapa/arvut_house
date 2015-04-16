require 'spec_helper'

describe Event do  
  before { 
    @event_type = FactoryGirl.create(:event_type) 
    @person = FactoryGirl.create(:person, admin: false)
    @event = @event_type.events.new(description: 'Event Descr For Test Event 2')    
  }
              
  subject { @event }  
  
  describe "event attributes" do 
    it { should respond_to(:event_date) }
    it { should respond_to(:description) }
    it { should respond_to(:event_type_id) }
  end
  
  describe "event relations" do
    it { should respond_to(:event_type) }  
    it { should respond_to(:people) } 
    it { should respond_to(:person_event_relationships) }
  end 
  
  its(:event_type) { should eq @event_type }  
  
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
    before {@event.event_type_id = -1}
    it { should_not be_valid }    
  end
    
  describe "event type id and event date is already taken" do
    before do
      event_with_same_data = @event.dup
      event_with_same_data.save
    end
    it { should_not be_valid }
  end
  
  describe "with description that is too long" do
    before { @event.description = "a" * 256 }
    it { should_not be_valid }
  end
   
  describe "with description that is size 255" do
    before { @event.description = "a" * 255 }
    it { should be_valid }
  end 
   
  describe "with description is not present" do
    before { @event.description = nil }
    it { should be_valid }
  end  
  
  describe "people association" do
    let(:second_person) {FactoryGirl.create(:person, admin: false)}
    let(:third_person) {FactoryGirl.create(:person, admin: false)}
    let(:not_related_person) {FactoryGirl.create(:person, admin: false)}
    before do
      @event.save
      @event.add_person!(@person)
      @event.add_person!(second_person)
      @event.add_person!(third_person)
    end     
    
    its(:people) { should include @person } 
    its(:people) { should include second_person }
    its(:people) { should include third_person } 
    its(:people) { should_not include not_related_person }
    
    it "should return false for not existing perosn is_perosn_exists" 
    
    it "should exists all peaople by is_perosn_exists" do
      # expect { @event.is_perosn_exists?(@person) }.to be_true
      # expect { @event.is_perosn_exists?(second_person) }.to be_true
      # expect { @event.is_perosn_exists?(third_person) }.to be_true
      #expect { @event.is_perosn_exists?(not_related_person) }.to be_true
      expect(PersonEventRelationship.where(person_id: @person.id)).not_to be_empty
      expect(PersonEventRelationship.where(person_id: second_person.id)).not_to be_empty
      expect(PersonEventRelationship.where(person_id: third_person.id)).not_to be_empty
      expect(PersonEventRelationship.where(person_id: not_related_person.id)).to be_empty
    end 
    
    it "should remove person by remove_person!" do
      @event.remove_person!(second_person)
      #expect { @event.is_perosn_exists?(second_person) }.to be_true
      expect(PersonEventRelationship.where(person_id: second_person.id)).to be_empty     
    end 
    
    it "should have the right peaople in the right order" do
      expect(@event.people.to_a).to eq [@person, second_person, third_person]
    end 
    
    it "should destroy all releshions when event is deleted" do      
      people_arr = @event.people.to_a
      expect(people_arr).to include(@person, second_person, third_person)
      @event.destroy  
            
      people_arr.each do |lup_person|
        expect(PersonEventRelationship.where(person_id: lup_person.id)).to be_empty
      end
    end  
  end
  
end
