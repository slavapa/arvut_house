class PersonRolesController < ApplicationController
  before_action :check_current_user_admin
  
  def create 
    @person = Person.find(params[:person_role][:person_id])
    @role = Role.find(params[:person_role][:role_id])
    @person.add_role!(@role)
    
    respond_to do |format|
      format.html {redirect_to roles_person_path(@person)}
      format.js      
    end
  end

  def destroy
    @role = Language.find(params[:person_role][:role_id])
    @person = Person.find(params[:person_role][:person_id])
    @person.remove_role!(@role)
    respond_to do |format|
      format.html {redirect_to roles_person_path(@person)}
      format.js      
    end
  end
end
