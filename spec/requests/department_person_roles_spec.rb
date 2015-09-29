require 'spec_helper'

I18n.default_locale = :en

describe "DepartmentPersonRoles" do
    let(:lng) { I18n.default_locale }
    subject { page }

    let(:admin) { FactoryGirl.create(:admin) }

    before  do
        Person.delete_all
        Role.delete_all
        Department.delete_all
        DepartmentPersonRole.delete_all
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

        @rows_before = DepartmentPersonRole.count

        sign_in admin
    end


  describe "Department Person Roles creation" do
    before { visit new_department_person_role_path(lng) }

    it { should have_title(full_title('Departments And Roles For Person')) }
    it { should have_content('New Departments And Roles For Person') }
    it { should have_link('list_link_header', href: department_person_roles_path(lng)) }
    it { should have_link('save_link_header') }

    it { should have_selector "form label[for='department_person_role_department_id']", text: "Department" }
    it {should have_select 'department_person_role_department_id'}
    it {find("#department_person_role_department_id").value.should eq(@department1.id.to_s)}

    it "Department options" do
        expect(page.all('select#department_person_role_department_id option').
        map(&:value)).to eq([@department1.id.to_s, @department2.id.to_s, @department3.id.to_s])
    end

    it { should have_selector "form label[for='department_person_role_person_full_name']", text: "Person Full Name" }
    it {should have_field 'department_person_role_person_full_name'}

    it {have_selector("input", :type => "hidden", :name => "department_person_role[person_id]")}

    it { should have_selector "form label[for='department_person_role_role_id']", text: "Role" }
    it {should have_select 'department_person_role_role_id'}
    it {find("#department_person_role_role_id").value.should eq(@role1.id.to_s)}

    it "Role options" do
        expect(page.all('select#department_person_role_role_id option').
        map(&:value)).to eq([@role1.id.to_s, @role2.id.to_s, @role3.id.to_s])
    end



    describe "with invalid information" do
    #   it "should not create a Payment Type" do
    #     page.find("#new_payment_type").submit_form!
    #     expect {click_link("Save")}.not_to change(PaymentType, :count)
    #   end

    #   describe "error messages" do
    #     before {page.find("#new_payment_type").submit_form!}
    #     it { should have_content('error') }
    #   end

    #   describe "with empty frequency" do
    #     before {
    #       fill_in 'payment_type_name', with: 'Payment Type Name'
    #       expect {page.find("#new_payment_type").submit_form!}.not_to change(PaymentType, :count)
    #     }
    #     it { should have_selector('.alert-error') }
    #     it { should have_content('error') }
    #   end

    #   describe "with empty name" do
    #     before {
    #       page.select 'General', :from => 'Frequency'
    #       expect {page.find("#new_payment_type").submit_form!}.not_to change(PaymentType, :count)
    #     }
    #     it { should have_selector('.alert-error') }
    #     it { should have_content('error') }
    #   end
    end

    # describe "with valid information" do
    #   before do
    #     fill_in 'payment_type_name', with: 'Payment Type Name'
    #     page.select 'General', :from => 'Frequency'
    #   end

    #   it "should create a Payment Type" do
    #     expect { page.find("#new_payment_type").submit_form! }.to change(PaymentType, :count).by(1)
    #   end
    # end

    # describe "with name that alrady exists" do
    #   let(:pt1) {FactoryGirl.create(:payment_type,
    #       name: 'PaymentType to test name that laready exists', frequency: 1)}
    #   before {
    #     fill_in 'payment_type_name', with: pt1.name
    #     page.select 'General', :from => 'Frequency'
    #   }

    #   it "should not create a Payment Type" do
    #     expect {page.find("#new_payment_type").submit_form!}.not_to change(PaymentType, :count)
    #   end

    #   describe "error messages" do
    #     before do
    #       page.find("#new_payment_type").submit_form!
    #     end

    #     it { should have_selector('div.alert.alert-error') }
    #   end
    # end

    # #    describe "click list link should brings index page" do
    # #      it do
    # #        click_link("List")
    # #        expect(page).to have_content 'List of Payment Types'
    # #      end
    # #    end
    # #
    # #    describe "click Save link should brings error" do
    # #      it do
    # #        click_link_or_button("list_link_header")
    # #      end
    # #    end

  end

    describe "index" do
        let(:num_of_rows) {30 - @rows_before}
        before do
          visit department_person_roles_path
        end

        it { should have_title(full_title('Departments And Roles For Person')) }
        it { should have_content('Departments And Roles For Person') }
        it { should have_link('new_link_header', href: new_department_person_role_path(lng)) }

        describe "should list all DepartmentPersonRoles" do
            before  do
                #Role.delete_all
                #Department.delete_all
                #DepartmentPersonRole.delete_all
                num_of_rows.times do |index|
                    role = FactoryGirl.create(:role, name:"role_#{index}" )
                    department = FactoryGirl.create(:department, name:"department_#{index}")
                    person = FactoryGirl.create(:person, admin: false,
                        name:"name_#{index}", family_name:"family_name_#{index}",
                        email:"department_person_role_#{index}@example.com")

                    FactoryGirl.create(:department_person_role,
                    department: department, person: person, role: role)
                end
                visit department_person_roles_path
            end
            after  do
                #Person.delete_all
                #Role.delete_all
                #Department.delete_all
                #DepartmentPersonRole.delete_all
            end

            it "DepartmentPersonRole count" do
                expect(DepartmentPersonRole.count).to eq(num_of_rows + @rows_before)
            end

            it "should list each role" do
                DepartmentPersonRole.all.each_with_index do |item, index|
                    expect(page).to have_selector("table.table-index td[@id='#{item.id.to_s}']")
                end
            end
        end

    end

end
