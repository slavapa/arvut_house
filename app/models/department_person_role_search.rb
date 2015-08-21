# encoding: utf-8
class DepartmentPersonRoleSearch
  include SearchObject.module(:model, :sorting, :will_paginate)
  
  scope { DepartmentPersonRole.inner_departments_people_roles }
  
  per_page 10
  
  sort_by 'departments.name', 'roles.name', 'people.name', 'people.family_name'
   
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
   
  option :sort_1 do |scope, value|
    scope.order value
  end
  
  option :sort_2 do |scope, value|
     scope.order value
  end
  
  option :sort_3 do |scope, value|
     scope.order value
  end
  
  option :sort_4 do |scope, value|
     scope.order value
  end
    
  def sort_params_arr
    [
      ["#{I18n.t('departments.searching.name')} #{I18n.t('a-z')}", 
        'departments.name asc'],
      ["#{I18n.t('departments.searching.name')} #{I18n.t('z-a')}", 
        'departments.name desc'], 
      ["#{I18n.t('roles.searching.name')} #{I18n.t('a-z')}", 
        'roles.name asc'], 
      ["#{I18n.t('roles.searching.name')} #{I18n.t('z-a')}", 
        'roles.name desc'], 
      ["#{I18n.t('people.searching.name')} #{I18n.t('a-z')}",  
        'people.name asc'],  
      ["#{I18n.t('people.searching.name')} #{I18n.t('z-a')}",  
        'people.name desc'],  
      ["#{I18n.t('people.searching.fam_name')} #{I18n.t('a-z')}", 
        'people.family_name asc'],  
      ["#{I18n.t('people.searching.fam_name')} #{I18n.t('z-a')}", 
        'people.family_name desc']              
    ]     
  end 
  
   
  def initialize(filters = {}, page = 1, atributes = {})
    @atributes = atributes
    filters = Hash.new if filters.nil?
    filters['sort'] = 'departments.name asc' unless filters.has_key?('sort')
    
    # if Rails.env.test?#TODO: Rspec Test doesn't work. Check how to reslove this for Rspec
      # super filters
    # else
    super filters, page    
      #filters['sort'] = 'people.name asc'
    # end
    reverted_sort_direction
  end  
  
  
  private
  
  def is_not_nil_empty?(value)
    !value.nil? && !value.empty? && value.strip.length > 0
  end
  
  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end
end