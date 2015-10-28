require 'rails_helper'

describe Department do

  before  do
    @department1 = FactoryGirl.create(:department, name:'department1', description: 'description 1')
    @department2 = FactoryGirl.create(:department, name:'department2', description: 'description 2')
    @department3 = FactoryGirl.create(:department, name:'department3', description: 'description 3')

    @role1 = FactoryGirl.create(:role, name:'role1')
    @person1 = FactoryGirl.create(:person, admin: false, name: 'person1', family_name: 'family_name_1')
    @department_person_role1 = FactoryGirl.create(:department_person_role,
                        department: @department1, person: @person1, role: @role1)
  end

  subject { @department1 }

  it { should be_valid }

  describe "Department attributes" do
    it { should respond_to(:name) }
    it { should respond_to(:description) }
  end

  describe "Department relations" do
    it { should respond_to(:department_person_roles) }
    it { should respond_to(:people) }
    it { should respond_to(:roles) }
  end

  describe "when Department is valid" do
    before { @department1.save }
    it { should be_valid }
  end

  describe "Should Create Department row in DB and change count by 1" do
    let(:department4) { FactoryGirl.create(:department, name:'department4')}

    it "should change count of Department in DB  by 1" do
      expect { department4.save }.to change(Department, :count).by(1)
    end
  end

  describe "when Department name is balnk" do
    before { @department1.name = nil }
    it { should_not be_valid }
  end

  describe "When Department Name is to long" do
    before { @department1.name = "a" * 61 }
    it { should_not be_valid }
  end

  describe "When Department description is to long" do
    before { @department1.description = "a" * 256 }
    it { should_not be_valid }
  end

  describe "Duplicated row" do
    let(:department_dup) {  @department1.dup}

    it "should not change count of DepartmentPersonRole in DB  by 1" do
      expect { department_dup.save }.to_not change(DepartmentPersonRole, :count)
    end
  end

  describe "When department is already in use by DepartmentPersonRole" do
    let(:role4) { FactoryGirl.create(:role, name:'role4')}
    let(:person4) { FactoryGirl.create(:person, admin: false) }
    let(:department4) { FactoryGirl.create(:department, name:'department4')}
    let(:department_person_role4) {  FactoryGirl.create(:department_person_role,
                        department: department4, person: person4, role: role4)}

    it "should not delete a department" do
      expect { role4.destroy }.not_to change(Department, :count)
    end
  end

  describe "Department associations" do
    let(:role4) { FactoryGirl.create(:role, name:'role4')}
    let(:person4) { FactoryGirl.create(:person, admin: false) }
    let(:department4) { FactoryGirl.create(:department, name:'department4')}
    let(:department_person_role4) {  FactoryGirl.create(:department_person_role,
                        department: department4, person: person4, role: role4)}

    let(:role5) { FactoryGirl.create(:role, name:'role4')}
    let(:person5) { FactoryGirl.create(:person, admin: false) }
    let(:department_person_role5) {  FactoryGirl.create(:department_person_role,
                        department: department4, person: person5, role: role5)}


    it "should include department_person_roles" do
      expect(department4.department_person_roles).to include(department_person_role4)
    end

  end

end
