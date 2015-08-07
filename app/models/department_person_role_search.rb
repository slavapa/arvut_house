# encoding: utf-8
class DepartmentPersonRoleSearch
  include SearchObject.module(:model, :sorting, :will_paginate)
  
  scope { DepartmentPersonRole.inner_departments_people_roles }
  
  per_page 10
   
  option :person_gender do |scope, value| 
    scope.where 'people.gender = ?', value if is_not_nil_empty?(value)
  end
   
  option :department_name do |scope, value|
    scope.where 'departments.name LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
    
  option :role_name do |scope, value|
    scope.where 'roles.name LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
  
  option :person_name do |scope, value|
    scope.where 'people.name LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
  
  option :family_name do |scope, value|
    scope.where 'people.family_name LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
  
  private
  
  def is_not_nil_empty?(value)
    !value.nil? && !value.empty? && value.strip.length > 0
  end
  
  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end
end