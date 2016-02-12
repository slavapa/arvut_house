class GuestsController < ApplicationController
   
  def index
    if request.path_parameters[:format] == 'xlsx'
      @people = Person.all
    else
      @search = PersonSearch.new params[:f], params[:page]
      #@people = Person.paginate(page: params[:page]).order("name, family_name ASC")
      @people = @search.results
    end
    
    respond_to do |format|
      format.html
      format.xlsx
    end
  end
  
end
