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
    let(:stat) { OrgRelationStatus.new(name: 'Active') }
    
    it "should change rowcount by 1" do
      expect { stat.save }.to change(OrgRelationStatus, :count).by(1)
    end          
  end
  
  describe "when status is already in use by person" do
    let(:stat) { OrgRelationStatus.create(name: 'status is already in use by perso') }
    before do
        @status.save
        person = @status.people.create(
            name: "Person For test delete status #{@status.name}")        
    end
    
    it "should not delete a status" do
      expect { @status.destroy }.to change(OrgRelationStatus, :count).by(-1)
    end          
  end
  
end
