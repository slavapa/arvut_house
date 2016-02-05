require 'rails_helper'

describe OrgRelationStatus do     
  before  do
    @status = OrgRelationStatus.new(name: 'Frend')
  end 
  subject { @status }
  it { should be_valid }
  
  describe "Status attributes" do 
    it { should respond_to(:name) }
    it { should respond_to(:description) }
  end
  
  describe "Status relations" do
    it { should respond_to(:people) }
  end 
  
  describe "When Status Name is not present" do
    before { @status.name = nil }
    it { should_not be_valid }    
  end
    
  describe "When Status Name is to long" do
    before { @status.name = "a" * 61 }
    it { should_not be_valid }    
  end 
    
  describe "When Description is to long" do
    before { @status.description = "a" * 255 }
    it { should_not be_valid }    
  end 
  
  describe "when status name is already taken" do    
    before do
      dup_stat = @status.dup
      dup_stat.name = @status.name.upcase
      dup_stat.save
    end
    it { should_not be_valid }
  end
  
  describe "should change rowcount by 1" do
    let(:stat) { OrgRelationStatus.new(name: 'should change rowcount by 1') }
    
    it "should change rowcount by 1" do
      expect { stat.save }.to change(OrgRelationStatus, :count).by(1)
    end          
  end
  
  
  describe "when status is already in use by person" do
    let(:stat) { OrgRelationStatus.new(name: 'when status is already in use by person') }
    before do
      
    
      # @stat1 = OrgRelationStatus.new(name: 'Active1')
      # @stat1.save
      # @person1 = @stat1.people.new(name: "Person For test delete status #{@stat1.name}") 
      # @person1.save
      
    end
    
    it "should not delete a status" do
      expect {  stat.save }.to change(OrgRelationStatus, :count).by(1)
    end          
  end
  
  # describe "when status is already in use by person" do
  #   let(:stat) { OrgRelationStatus.create(name: 'status is already in use by person') }
  #   before do
  #       @status.save
  #       person = @status.people.create(
  #           name: "Person For test delete status #{@status.name}")        
  #   end
    
  #   it "should not delete a status" do
  #     expect { @status.destroy }.to change(OrgRelationStatus, :count).by(-1)
  #   end          
  # end
  
  # describe "when status is already in use by person" do
  #   #let(:per) { Person.create(name: 'status is already in use by perso', org_relation_status_id: @status.id) }
  #   #@stat1 = OrgRelationStatus.create(name: 'Active1')
  #   #@per = Person.create(name: 'status is already in use by perso', org_relation_status_id: @stat1.id)
    
  #   before do
  #     @status2 = OrgRelationStatus.create(name: 'status2')
  #     @status.save
  #     @per1 = Person.new(name: 'status is already in use by perso')
  #     @per2 = Person.create(name: 'per2')
  #     @per3 = Person.find(@per2.id)
  #     @statToCheck = @per3.org_relation_status_id
  #     @per3.org_relation_status_id = @status2.id
  #     @per3.save
  #       #@@status.save
  #       # person = @status.people.create(
  #       #     name: "Person For test delete status #{@status.name}")        
  #   end
    
  #   it "should not delete a status" do
  #     expect { @per1.save }.to change(Person, :count).by(1)
  #   end 
    
  
  #   it "check person org status" do
  #     @per3.org_relation_status.name.should eq(@status2.name)
  #   end  
  # end
  
end
