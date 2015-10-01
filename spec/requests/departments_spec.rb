require 'spec_helper'

I18n.default_locale = :en

describe "Departments" do
  let(:lng) { I18n.default_locale }
  subject { page }

  let(:admin) { FactoryGirl.create(:admin) }

  before  do
    @debuge_info = "test123"
    @department1 = FactoryGirl.create(:department, name:'department1', description: 'description 1')
    @department2 = FactoryGirl.create(:department, name:'department2', description: 'description 2')
    @department3 = FactoryGirl.create(:department, name:'department3', description: 'description 3')
    @rows_before = Department.count
    sign_in admin
  end

  after {log_test  @debuge_info}
  # describe "Test", :type => :selenium do

  describe "index page" do
    let(:num_of_rows) {30 - @rows_before}
    before do
      visit departments_path(lng)
    end

    it { expect(current_path).to eq(departments_path(lng))}
    it { should have_title(full_title('List of Departments')) }
    it { should have_content('List of Departments') }
    it { should have_link('new_link_header', text: 'New', href: new_department_path(lng)) }

    describe "should list all Departments" do
        before  do
            num_of_rows.times do |index|
                department = FactoryGirl.create(:department)
            end
        end


        it "Departments count" do
            expect(Department.count).to eq(num_of_rows + @rows_before)
        end

        it "should list each role" do
            visit departments_path
            Department.all.each_with_index do |item, index|
              expect(page).to have_link(item.name)
            end
        end
    end

    describe "click New link button should brings new page" do
        before {click_link("New")}
        it{expect(current_path).to eq(new_department_path(lng))}
    end

    describe "click link button should brings Editing page" do
        before {click_link(@department1.name)}
        it { expect(current_path).to eq(
            edit_department_path(lng, @department1))}
    end
  end

  describe "Department creation" do
      before { visit new_department_path(lng) }

      it { expect(current_path).to eq(new_department_path(lng))}
      it { should have_title(full_title('New Department')) }
      it { should have_content('New Department') }
      it { should have_link('list_link_header', href: departments_path(lng)) }
      it { should have_link('save_link_header') }

      it { should have_selector "form label[for='department_name']", text: "Name" }
      it { should have_field 'department_name'}

      it { should have_selector "form label[for='department_description']", text: "Description" }
      it { should have_field 'department_description'}


      describe "with invalid information empty name" do
          before do
              #fill_in 'department_name', with: ""
              page.find("#new_department").submit_form!
          end
          it "should not create a DepartmentPersonRole with empty person" do
              expect(Department.count).to eq(@rows_before)
              should have_selector('.alert-error')
              should have_content("Name can't be blank")
          end
      end

      describe "with valid information"  do
          before do
              fill_in 'department_name', with: "department4"
              page.find("#new_department").submit_form!
          end

          it "should create a Department" do
              expect(current_path).not_to eq(new_department_path(lng))
              expect(Department.count).to eq(@rows_before + 1)
          end
      end

    describe "with department that alrady exists" do
        before do
            fill_in 'department_name', with: @department1.name
            page.find("#new_department").submit_form!
        end
        it "should not create a Department" do
            expect(Department.count).to eq(@rows_before)
            should have_selector('.alert-error')
            should have_content('Name has already been taken')
        end
    end

    describe "with department name that to long size" do
        before do
            fill_in 'department_name', with: "a" * 61
            page.find("#new_department").submit_form!
        end
        it "should not create a Department" do
            expect(Department.count).to eq(@rows_before)
            should have_selector('.alert-error')
            should have_content('Name is too long (maximum is 60 characters)')
        end
    end

    describe "with department description that to long size" do
        before do
            fill_in 'department_name', with: "aaaa"
            fill_in 'department_description', with: "a" * 256
            page.find("#new_department").submit_form!
        end
        it "should not create a Department" do
            expect(Department.count).to eq(@rows_before)
            should have_selector('.alert-error')
            should have_content('Description is too long (maximum is 255 characters)')
        end
    end

    describe "test with max char size valid information"  do
        before do
            fill_in 'department_name', with: "a" * 60
            fill_in 'department_description', with: "a" * 255
            page.find("#new_department").submit_form!
        end

        it "should create a Department" do
            expect(current_path).not_to eq(new_department_path(lng))
            expect(Department.count).to eq(@rows_before + 1)
        end
    end



    describe "click List link should brings index page" do
      before {click_link("List")}
      it {expect(current_path).to eq(departments_path(lng))}
    end
  end


  describe "Department creation" do
      before { visit edit_department_path(lng, @department2) }

      it { expect(current_path).to eq(edit_department_path(lng, @department2))}
      it { should have_title(full_title('Editing Department')) }
      it { should have_content('Editing Department') }
      it { should have_link('list_link_header', href: departments_path(lng)) }
      it { should have_link('save_link_header') }

      it { should have_selector "form label[for='department_name']", text: "Name" }
      it { should have_field 'department_name', with: @department2.name}

      it { should have_selector "form label[for='department_description']", text: "Description" }
      it { should have_field 'department_description', with: @department2.description}


      describe "with invalid information" do
          before do
              fill_in 'department_name', with: ""
              page.find("form.edit_department").submit_form!
          end
          it "should not create a DepartmentPersonRole with empty person" do
              should have_selector('.alert-error')
              should have_content("Name can't be blank")
          end
      end

      describe "with valid information"  do
          before do
              fill_in 'department_name', with: "#{@department2.name} 123"
              fill_in 'department_description', with: "#{@department2.description} 123"
              page.find("form.edit_department").submit_form!
          end

          it "should create a Department" do
            should have_selector('.alert-success')
            should have_content('Department was successfully updated')
          end
      end

    describe "with department that alrady exists" do
        before do
            fill_in 'department_name', with: @department1.name
            page.find("form.edit_department").submit_form!
        end
        it "should not create a Department" do
            should have_selector('.alert-error')
            should have_content('Name has already been taken')
        end
    end

    describe "with department name that to long size" do
        before do
            fill_in 'department_name', with: "a" * 61
            page.find("form.edit_department").submit_form!
        end
        it "should not create a Department" do
            should have_selector('.alert-error')
            should have_content('Name is too long (maximum is 60 characters)')
        end
    end

    describe "with department description that to long size" do
        before do
            fill_in 'department_description', with: "a" * 256
            page.find("form.edit_department").submit_form!
        end
        it "should not create a Department" do
            should have_selector('.alert-error')
            should have_content('Description is too long (maximum is 255 characters)')
        end
    end

    describe "click List link should brings index page" do
      before {click_link("List")}
      it {expect(current_path).to eq(departments_path(lng))}
    end

    describe "click New link button should brings new page" do
        before {click_link("New")}
        it{expect(current_path).to eq(new_department_path(lng))}
    end

    describe "click Delete link button should brings index page and delete row" do
        before {click_link("Delete")}
        it{expect(current_path).to eq(departments_path(lng))}
        it {expect(Department.count).to eq(@rows_before-1)}
    end
  end

end

# # https://www.relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec
# RSpec.feature "Widget management", :type => :feature do
#   scenario "User creates a new widget" do
#     visit departments_path(lng)

#     #expect(page).to have_text("Widget was successfully created.")
#     it { should have_title(full_title('List of Departments')) }
#   end
# end
