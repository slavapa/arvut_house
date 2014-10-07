require 'spec_helper'

describe PersonRole do
  let(:person1) { FactoryGirl.create(:person, admin: false) }
  let(:role1) {FactoryGirl.create(:role, name: 'Role to test person role relationship')}
  
  before do
    @person_role = person1.person_roles.build(role_id: role1.id)
  end  
  
  subject { @person_role } 
   
  it { should be_valid }
  its(:person) { should eq person1 }
  its(:role) { should eq role1 }
    
  describe "person_roles attributes" do 
    it { should respond_to(:person_id) }
    it { should respond_to(:role_id) }
  end
    
  describe "person_roles relations" do
    it { should respond_to(:role) }  
    it { should respond_to(:person) } 
  end 
     
  it "should increase rows" do
    expect { @person_role.save }.to change(PersonRole, :count).by(1)
  end       
    
  describe "when person_id is not present" do
    before { @person_role.person_id = nil }
    it { should_not be_valid }
  end
   
  describe "when role_id is not present" do
    before { @person_role.role_id = nil }
    it { should_not be_valid }
  end 
  
  describe "should check foregn key to people" do
    before { 
      @person_role.person_id = -1 
    }
    it { should_not be_valid }
       
    it "should not add row when person_id is invalid" do
      expect { @person_role.save }.not_to change(PersonRole, :count)
    end
  end
  
  describe "should check foregn key to roles" do
    before { 
      @person_role.role_id = -1 
    }
    it { should_not be_valid }
       
    it "should not add row when role_id is invalid" do
      expect { @person_role.save }.not_to change(PersonRole, :count)
    end
  end
end
