require 'rails_helper'

describe DepartmentPersonRole do
  before  do
    @role1 = FactoryGirl.create(:role, name:'role1')
    @role2 = FactoryGirl.create(:role, name:'role2')
    @role3 = FactoryGirl.create(:role, name:'role3')
    @department1 = FactoryGirl.create(:department, name:'department1')
    @department2 = FactoryGirl.create(:department, name:'department2')
    @department3 = FactoryGirl.create(:department, name:'department3')
    @person1 = FactoryGirl.create(:person, admin: false, name: 'person1', family_name: 'family_name_1')
    @person2 = FactoryGirl.create(:person, admin: false, name: 'person2', family_name: 'family_name_2')
    @person3 = FactoryGirl.create(:person, admin: false, name: 'person3')

    @department_person_role1 = FactoryGirl.create(:department_person_role,
                        department: @department1, person: @person1, role: @role1)
    @department_person_role2 = FactoryGirl.create(:department_person_role,
                        department: @department2, person: @person2, role: @role2)
    @department_person_role3 = FactoryGirl.create(:department_person_role,
                        department: @department3, person: @person3, role: @role3)
  end

  subject { @department_person_role1 }

  it { should be_valid }

  describe "DepartmentPersonRole attributes" do
    it { should respond_to(:department_id) }
    it { should respond_to(:person_id) }
    it { should respond_to(:role_id) }
  end

  describe "event relations" do
    it { should respond_to(:department) }
    it { should respond_to(:person) }
    it { should respond_to(:role) }
  end

  describe "when payment is valid" do
    before { @department_person_role1.save }
    it { should be_valid }
  end

  describe "Should Create DepartmentPersonRole row in DB and change count by 1" do
    let(:role4) { FactoryGirl.create(:role, name:'role4')}
    let(:person4) { FactoryGirl.create(:person, admin: false) }
    let(:department4) { FactoryGirl.create(:department, name:'department4')}
    let(:department_person_role4) {  FactoryGirl.create(:department_person_role,
                        department: department4, person: person4, role: role4)}

    it "should change count of DepartmentPersonRole in DB  by 1" do
      expect { department_person_role4.save }.to change(DepartmentPersonRole, :count).by(1)
    end
  end

  describe "when department_id is not present" do
    before { @department_person_role1.department_id = nil }
    it { should_not be_valid }
  end

  describe "when person_id is not present" do
    before { @department_person_role1.person_id = nil }
    it { should_not be_valid }
  end

  describe "when role_id is not present" do
    before { @department_person_role1.role_id = nil }
    it { should_not be_valid }
  end

  describe "Duplicated row" do
    let(:department_person_role_dup) {  @department_person_role1.dup}

    it "should not change count of DepartmentPersonRole in DB  by 1" do
      expect { department_person_role_dup.save }.to_not change(DepartmentPersonRole, :count).by(1)
    end
  end

  describe "DepartmentPersonRole associations" do
    # its(:department) { should eq @department1 }
    # its(:person) { should eq @person1 }
    # its(:role) { should eq @role1 }

    it "should include person through @person1.department_person_roles" do
      expect(@person1.department_person_roles).to include(@department_person_role1)
    end

    it "should include department through @department1.department_person_roles" do
      expect(@department1.department_person_roles).to include(@department_person_role1)
    end

    it "should include role through @role1.department_person_roles" do
      expect(@role1.department_person_roles).to include(@department_person_role1)
    end
  end



  describe  "should check foregn key to people" do
    let(:department_person_role4) {  FactoryGirl.create(:department_person_role,
                        department: @department1, person: @person2, role: @role2)}

    before { department_person_role4.person_id = -1 }

    it "DepartmentPersonRole should not not be valid" do
      expect(department_person_role4).to_not be_valid
    end

    it "should not change count of DepartmentPersonRole in DB  by 1" do
      expect { department_person_role4.save }.not_to change(DepartmentPersonRole, :count).by(1)
    end
  end

  describe  "Should check foregn key to departments" do
    let(:department_person_role4) {  FactoryGirl.create(:department_person_role,
                        department: @department1, person: @person2, role: @role2)}

    before { department_person_role4.department_id = -1 }

    it "DepartmentPersonRole should not not be valid" do
      expect(department_person_role4).to_not be_valid
    end

    it "should not change count of DepartmentPersonRole in DB  by 1" do
      expect { department_person_role4.save }.not_to change(DepartmentPersonRole, :count).by(1)
    end
  end

  describe  "Should check foregn key to roles" do
    let(:department_person_role4) {  FactoryGirl.create(:department_person_role,
                        department: @department1, person: @person2, role: @role2)}

    before { department_person_role4.role_id = -1 }

    it "DepartmentPersonRole should not not be valid" do
      expect(department_person_role4).to_not be_valid
    end

    it "should not change count of DepartmentPersonRole in DB  by 1" do
      expect { department_person_role4.save }.not_to change(DepartmentPersonRole, :count).by(1)
    end
  end

  describe "When role is already in use by DepartmentPersonRole" do
    it "should not delete a role" do
      expect { @role1.destroy }.not_to change(Role, :count)
    end
  end

  describe "When department is already in use by DepartmentPersonRole" do
    it "should not delete a department" do
      expect { @department1.destroy }.not_to change(Department, :count)
    end
  end

  describe "Department array" do
    it "should have the right departments" do
      expected_array = {@department1.id => @department1.name,
                                    @department2.id => @department2.name,
                                     @department3.id => @department3.name}
      expect(@department_person_role1.departments_array).to eq(expected_array)
    end

    let(:department4) { FactoryGirl.create(:department, name:'department4')}
    it "should have the right departments after addding new department" do
      expected_array = {@department1.id => @department1.name,
                        @department2.id => @department2.name,
                        @department3.id => @department3.name,
                        department4.id => department4.name}
      expect(@department_person_role1.departments_array).to eq(expected_array)
    end

    it "should have the right departments after deleting new department" do
      department4.destroy
      expected_array = {@department1.id => @department1.name,
                                    @department2.id => @department2.name,
                                     @department3.id => @department3.name}
      expect(@department_person_role1.departments_array).to eq(expected_array)
    end
  end

  describe "Roles array" do
    it "should have the right roles" do
      expected_array = {@role1.id => @role1.name, @role2.id => @role2.name,
                              @role3.id => @role3.name}
      expect(@department_person_role1.roles_array).to eq(expected_array)
    end

    let(:role4) { FactoryGirl.create(:role, name:'role4')}
    it "should have the right roles after adding new role" do
      expected_array = {@role1.id => @role1.name, @role2.id => @role2.name,
                              @role3.id => @role3.name,  role4.id => role4.name}
      expect(@department_person_role1.roles_array).to eq(expected_array)
    end

    it "should have the right roles after deliting new role" do
      role4.destroy
      expected_array = {@role1.id => @role1.name, @role2.id => @role2.name,
                              @role3.id => @role3.name}
      expect(@department_person_role1.roles_array).to eq(expected_array)
    end

  end

  describe "Person Full Name" do
    let(:department_person_role4) {DepartmentPersonRole.find(@department_person_role1.id)}

    it "should have the right Person Full Name" do
      expect(department_person_role4.person_full_name).to eq("#{@person1.name} #{@person1.family_name}".strip)
    end

    it "should not be valid when Person Full Name not exists" do
      department_person_role4.person_full_name = "Not Valid Person Full Name"
      department_person_role4.save
      expect(department_person_role4).to_not be_valid
    end

    it "should be valid when Person Full Name exists" do
      department_person_role4.person_full_name = "#{@person2.name} #{@person2.family_name}".strip
      department_person_role4.save
      expect(department_person_role4).to be_valid
    end
  end
end
