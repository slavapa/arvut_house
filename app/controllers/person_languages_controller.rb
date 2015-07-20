class PersonLanguagesController < ApplicationController
  before_action do |controller|
    @person = Person.find(params[:person_language][:person_id])
    authorize_current_user_by_person(@person)
  end
  
  def create 
    #@person = Person.find(params[:person_language][:person_id])
    @language = Language.find(params[:person_language][:language_id])
    @person.add_language!(@language)
    
    respond_to do |format|
      format.html {redirect_to languages_person_path(@person)}
      format.js      
    end
  end

  def destroy
    @language = Language.find(params[:person_language][:language_id])
    #@person = Person.find(params[:person_language][:person_id])
    @person.remove_language!(@language)
    respond_to do |format|
      format.html {redirect_to languages_person_path(@person)}
      format.js      
    end
  end
end
