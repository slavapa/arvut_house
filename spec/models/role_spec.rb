require 'spec_helper'

describe Role do       
  before  do
    @role = Role.new(name: "Manager Test 1")
  end 
  subject { @role }
  it { should be_valid }
   
  describe "Role attributes" do
    it { should respond_to(:name) }  
  end
   
  describe "Event Type relations" do
    # it { should respond_to(:person_roles) }  
    it { should respond_to(:people) }
  end
  
  describe "When Role Name is not present" do
    before { @role.name = nil }
    it { should_not be_valid }    
  end
     
  describe "When Role Name is to long" do
    before { @role.name = "a" * 255 }
    it { should_not be_valid }    
  end
    
  describe "When Role Name is max long" do
    before { @role.name = "a" * 254 }
    it { should be_valid }    
  end
  
  describe "when role name is already taken" do    
    before do
      role_with_same_name = @role.dup
      role_with_same_name.name = @role.name.upcase
      role_with_same_name.save
    end
    it { should_not be_valid }
  end
  
  
  # describe "when role is already in use by person" do
  #   let(:role1) { Role.create!(name: 'Role:' + DateTime.now.to_s) }
  #   let!(:person1) {FactoryGirl.create(:person)}
  #   before do
  #     role1.save
  #     person1.add_role!(role1)      
  #   end
  #   it "should not delete a role" do
  #     expect { role1.destroy }.not_to change(Role, :count)
  #   end          
  # end
  
  describe "Should Create Role row in DB and change count by 1" do 
    let(:role1) { Role.create!(name: 'Role:' + DateTime.now.to_s) }
    
    it "should change count of Role in DB  by 1" do
      expect { role1.save }.to change(Role, :count).by(1)
    end          
  end
end
