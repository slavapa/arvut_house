require 'rails_helper'

describe Status do     
  before  do
    @status = Status.new(name: 'Active')
  end 
  subject { @status }
  it { should be_valid }
  
  describe "Status attributes" do 
    it { should respond_to(:name) }
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
  
  describe "when status name is already taken" do    
    before do
      dup_stat = @status.dup
      dup_stat.name = @status.name.upcase
      dup_stat.save
    end
    it { should_not be_valid }
  end
  
  describe "when status is already in use by person" do
    let(:stat) { Status.create!(name: 'Not Active') }
    before do
      person = stat.people.create!(
        name: "Person For test delete status #{stat.name}")        
    end
    
    it "should not delete a status" do
      expect { stat.destroy }.not_to change(Status, :count)
    end          
  end
end
