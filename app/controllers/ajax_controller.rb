class AjaxController < ApplicationController
  def users
    if params[:term]
      searchCriteria= "%".concat(params[:term].concat("%"))
      users = Person.where("(people.name || ' ' || people.family_name)  LIKE ?", 
      searchCriteria)
    else
      users = Person.all
    end
    
    list = users.map {|u|
      fullName = "#{u.name} #{u.family_name}"
      Hash[ id: u.id, label: fullName, name: fullName, person_id: u.id]
      
    }
    render json: list
  end
end
