require 'spec_helper'
require 'timeout'

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
        @person3 = FactoryGirl.create(:person, admin: false, name: 'person3', family_name: 'family_name_3')

        @department_person_role1 = FactoryGirl.create(:department_person_role,
                            department: @department1, person: @person1, role: @role1)
        @department_person_role2 = FactoryGirl.create(:department_person_role,
                            department: @department2, person: @person2, role: @role2)
        @department_person_role3 = FactoryGirl.create(:department_person_role,
                            department: @department3, person: @person3, role: @role3)

        @rows_before = DepartmentPersonRole.count

        sign_in admin
    end

    # describe "Test", :type => :selenium do

    describe "index page" do
        let(:num_of_rows) {30 - @rows_before}
        before do
          visit department_person_roles_path(lng)
        end

        it { expect(current_path).to eq(department_person_roles_path(lng))}
        it { should have_title(full_title('Departments And Roles For Person')) }
        it { should have_content('Departments And Roles For Person') }
        it { should have_link('new_link_header', text: 'New',
                href: new_department_person_role_path(lng)) }
        it { should have_link('clear_link_header', text: 'Clear') }
        it { should have_link('search_link_header', text: 'Search') }
        it { should have_link('xlsx_download_path_by_search_link') }

        it { should have_selector "form#search-form label[for='f_department_name']", text: "Department" }
        it { should have_selector("form#search-form input#f_department_name")}

        it { should have_selector "form#search-form label[for='f_role_name']", text: "Role" }
        it { should have_selector("form#search-form input#f_role_name")}

        it { should have_selector "form#search-form label[for='f_family_name']", text: "Family Name" }
        it { should have_selector("form#search-form input#f_family_name")}

        it { should have_selector "form#search-form label[for='f_person_gender']", text: "Gender" }
        it { should have_selector("form#search-form select#f_person_gender")}

        it { should have_selector "form#search-form label[for='f_sort_params_for']", text: "1 Sort By" }
        it { should have_selector("form#search-form select#f_sort")}

        it { should have_selector "form#search-form label[for='f_sort_params_for']", text: "2 Sort By" }
        it { should have_selector("form#search-form select#f_sort_2")}

        it { should have_selector "form#search-form label[for='f_sort_params_for']", text: "3 Sort By" }
        it { should have_selector("form#search-form select#f_sort_3")}

        it { should have_selector "form#search-form label[for='f_sort_params_for']", text: "4 Sort By" }
        it { should have_selector("form#search-form select#f_sort_4")}

        describe "should list all DepartmentPersonRoles" do
            before  do
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

            it "DepartmentPersonRole count" do
                expect(DepartmentPersonRole.count).to eq(num_of_rows + @rows_before)
            end

            it "should list each role" do
                DepartmentPersonRole.all.each_with_index do |item, index|
                    expect(page).to have_selector("table.table-index td[@id='#{item.id.to_s}']")
                end
            end
        end

        describe "click New link button should brings new page" do
            before {click_link("New")}
            it{expect(current_path).to eq(new_department_person_role_path(lng))}
        end

        describe "click link button should brings Editing page" do
            before {click_link(@department1.name)}
            it { expect(current_path).to eq(
                edit_department_person_role_path(lng, @department_person_role1))}
        end

        describe "click Delete link button should brings index page" do
            before {find("#delete_link_index_#{@department_person_role1.id}").click}
            it {expect(DepartmentPersonRole.count).to eq(@rows_before-1)}
        end

        # it "click Delete link button should brings index page" do
        #     expect { find("#delete_link_index_#{@department_person_role2.id}").
        #         click }.to(change(DepartmentPersonRole, :count).by(-1))
        # end

        pending "Search functionality"
    end

    describe "Department Person Roles creation" do
        before { visit new_department_person_role_path(lng) }

        it { expect(current_path).to eq(new_department_person_role_path(lng))}
        it { should have_title(full_title('Departments And Roles For Person')) }
        it { should have_content('New Departments And Roles For Person') }
        it { should have_link('list_link_header', href: department_person_roles_path(lng)) }
        it { should have_link('save_link_header') }

        it { should have_selector "form label[for='department_person_role_department_id']", text: "Department" }
        it { should have_select 'department_person_role_department_id'}
        it {find("#department_person_role_department_id").value.should eq(@department1.id.to_s)}

        it "Department options" do
            expect(page.all('select#department_person_role_department_id option').
            map(&:value)).to eq([@department1.id.to_s, @department2.id.to_s, @department3.id.to_s])
        end

        it { should have_selector "form label[for='department_person_role_person_full_name']", text: "Person Full Name" }
        it { should have_field 'department_person_role_person_full_name'}

        it { should have_selector("input#department_person_role_person_id")}

        it { should have_selector "form label[for='department_person_role_role_id']", text: "Role" }
        it { should have_select 'department_person_role_role_id'}
        it { find("#department_person_role_role_id").value.should eq(@role1.id.to_s)}

        it "Role options" do
            expect(page.all('select#department_person_role_role_id option').
            map(&:value)).to eq([@role1.id.to_s, @role2.id.to_s, @role3.id.to_s])
        end

        describe "with invalid information" do
            before do
                fill_in 'department_person_role_person_full_name', with: ""
                page.find("#new_department_person_role").submit_form!
            end
            it "should not create a DepartmentPersonRole with empty person" do
                expect{}.not_to(change(DepartmentPersonRole, :count))
                should have_selector('.alert-error')
                should have_content('error')
            end
        end

        describe "with valid information"  do
            before do
                fill_in 'department_person_role_person_full_name',
                    with: "#{@person2.name} #{@person2.family_name}"
            end

            it "should create aDepartmentPersonRole" do
                expect { page.find("#new_department_person_role").submit_form! }.to(
                            change(DepartmentPersonRole, :count).by(1))
            end
        end

        describe "with person that alrady exists" do
            before do
                fill_in 'department_person_role_person_full_name',
                    with: "#{@person1.name} #{@person1.family_name}"
                 page.find("#new_department_person_role").submit_form!
            end
            it "should not create a DepartmentPersonRole with empty person" do
                expect{}.not_to(change(DepartmentPersonRole, :count))
                should have_selector('.alert-error')
                should have_content('The form contains 1 error')
            end
        end

        describe "click List link should brings index page" do
            before {click_link("List")}
            it {expect(current_path).to eq(department_person_roles_path(lng))}
        end
    end


    describe "Editing Department Person Roles" do
        before { visit edit_department_person_role_path(lng, @department_person_role2) }

        it { expect(current_path).to eq(edit_department_person_role_path(lng, @department_person_role2))}
        it { should have_title(full_title('Departments And Roles For Person')) }
        it { should have_content('Editing Departments And Roles For Person') }
        it { should have_link('list_link_header', href: department_person_roles_path(lng)) }
        it { should have_link('save_link_header') }

        it { should have_selector "form label[for='department_person_role_department_id']", text: "Department" }
        it { should have_select 'department_person_role_department_id'}
        it {find("#department_person_role_department_id").value.should eq(@department2.id.to_s)}

        it "Department options" do
            expect(page.all('select#department_person_role_department_id option').
            map(&:value)).to eq([@department1.id.to_s, @department2.id.to_s, @department3.id.to_s])
        end

        it { should have_selector "form label[for='department_person_role_person_full_name']", text: "Person Full Name" }
        it { should have_field 'department_person_role_person_full_name',
                with: "#{@person2.name} #{@person2.family_name}"}

        it { should have_selector("input#department_person_role_person_id")}

        it { should have_selector "form label[for='department_person_role_role_id']", text: "Role" }
        it { should have_select 'department_person_role_role_id'}
        it { find("#department_person_role_role_id").value.should eq(@role2.id.to_s)}

        it "Role options" do
            expect(page.all('select#department_person_role_role_id option').
            map(&:value)).to eq([@role1.id.to_s, @role2.id.to_s, @role3.id.to_s])
        end

        describe "with invalid information" do
            before do
                fill_in 'department_person_role_person_full_name', with: ""
                page.find(".edit_department_person_role").submit_form!
            end
            it "should not update a DepartmentPersonRole with empty person" do
                should have_selector('.alert-error')
                should have_content('error')
            end
        end

        describe "with valid information"  do
            before do
                fill_in 'department_person_role_person_full_name',
                    with: "#{@person1.name} #{@person1.family_name}"
                page.find(".edit_department_person_role").submit_form!
            end

            it "should create aDepartmentPersonRole" do
                should have_selector('.alert-success')
                should have_content('Department And Role For Person was successfully updated')
            end
        end

        describe "with person that alrady exists" do
            before do
                page.select @department1.name, :from => 'Department'
                page.select @role1.name, :from => 'Role'
                fill_in 'department_person_role_person_full_name',
                    with: "#{@person1.name} #{@person1.family_name}"
                 page.find(".edit_department_person_role").submit_form!
            end
            it "should not Update a DepartmentPersonRole" do
                should have_selector('.alert-error')
                should have_content('The combination of Department, Person and Role already in use')
            end
        end

        describe "click List link should brings index page" do
            before {click_link("List")}
            it {expect(current_path).to eq(department_person_roles_path(lng))}
        end

        describe "click New link button should brings new page" do
            before {click_link("New")}
            it{expect(current_path).to eq(new_department_person_role_path(lng))}
        end

        describe "click Delete link button should brings index page" do
            before {click_link("Delete")}
            it{expect(current_path).to eq(department_person_roles_path(lng))}
            it {expect(DepartmentPersonRole.count).to eq(@rows_before-1)}
        end
    end


end
