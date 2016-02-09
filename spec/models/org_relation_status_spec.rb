require 'rails_helper'

describe OrgRelationStatus do     
  before  do
    OrgRelationStatus.delete_all
    @status = OrgRelationStatus.new(name: 'Frend New')
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
  
  describe "Duplicated row" do
    let(:stat) { OrgRelationStatus.new(name: 'Duplicated row') }
    let(:dup_stat) {  stat.dup}
   
    before do
      dup_stat.name = stat.name.upcase
      dup_stat.save
    end
    
    it "should not change count of OrgRelationStatus in DB  by 1" do
      expect { stat.save }.to_not change(OrgRelationStatus, :count)
    end
  end
  
  
  describe "should change rowcount by 1" do
    let(:stat) { OrgRelationStatus.new(name: 'should change rowcount by 1') }
    
    it "should change rowcount by 1" do
      expect { stat.save }.to change(OrgRelationStatus, :count).by(1)
    end          
  end
  
  describe "should delete record and change rowcount by -1" do
    let(:stat) { OrgRelationStatus.new(name: 'should change rowcount by -1') }
    before { stat.save }
    
    it "should change rowcount by 1" do
      expect { stat.destroy }.to change(OrgRelationStatus, :count).by(-1)
    end          
  end
   
  describe "when status is already in use by person" do
    let(:stat) { OrgRelationStatus.new(name: 'should not change rowcount') }
    before do
      stat.save
      person = stat.people.create(name: "test delete status id=#{stat.id} #{stat.name}")        
    end
    
    it "should not delete a status" do
      expect { stat.destroy }.not_to change(OrgRelationStatus, :count)
    end          
  end
  
  
  describe "statuses_array" do 
    let(:stat1) { OrgRelationStatus.create(name: 'status sa 1') }
    let(:stat2) { OrgRelationStatus.create(name: 'status sa 2') }
    let(:stat3) { OrgRelationStatus.create(name: 'status sa 3') }
    
    it "should have a statuses_array method for instance" do
      stat1.should respond_to(:statuses_array)
    end
    
    it "should have a statuses_array method for class" do
      OrgRelationStatus.should respond_to(:statuses_array)
    end
    
    it "should have a statuses_array method for class" do
      OrgRelationStatus.should respond_to(:reset_status_array)
    end
    
    it "should have the right departments" do
      expected_array = [[stat1.id, stat1.name].reverse, [stat2.id, stat2.name].reverse,
                         [stat3.id, stat3.name].reverse]
                          
      expect(OrgRelationStatus.statuses_array).to eq(expected_array)
    end
    
    let(:stat4) { FactoryGirl.create(:org_relation_status, name:'FactoryGirl status')}
    
    it "should have the right OrgRelationStatuses after addding new department" do
      expected_array = [[stat1.id, stat1.name].reverse, [stat2.id, stat2.name].reverse,
                         [stat3.id, stat3.name].reverse, [stat4.id, stat4.name].reverse]
                         
      expect(OrgRelationStatus.statuses_array).to eq(expected_array)
    end
    
    it "should have the right OrgRelationStatuses after deleting new statuses" do
      stat4.destroy
      expected_array = [[stat1.id, stat1.name].reverse, [stat2.id, stat2.name].reverse,
                         [stat3.id, stat3.name].reverse]
                         
      expect(OrgRelationStatus.statuses_array).to eq(expected_array)
    end
  end
  
end
