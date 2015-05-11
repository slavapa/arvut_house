class PersonDepartmentsController < ApplicationController
  def create
    @person = Person.find(params[:person_department][:person_id])
    @department = Department.find(params[:person_department][:department_id])
    @person.add_department!(@department)
    
    respond_to do |format|
      format.html {redirect_to departments_person_path(@person)}
      format.js      
    end
  end

  def destroy
    @department = Department.find(params[:person_department][:department_id])
    @person = Person.find(params[:person_department][:person_id])
    @person.remove_department!(@department)
    respond_to do |format|
      format.html {redirect_to departments_person_path(@person)}
      format.js      
    end
  end

end
