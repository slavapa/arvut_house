# encoding: utf-8
class PersonSearch
  include SearchObject.module(:model, :sorting, :will_paginate)
  
  #scope { Person.all.order("name, family_name ASC") }
  scope { Person.all }
  
  per_page 30
  
  sort_by :name, :family_name, :gender, :status_id
  
  option :person_id  
  option :gender 
  option :status_id
  
  option :name do |scope, value|
    scope.where 'name LIKE ?', escape_search_term(value)
  end
  
  option :family_name do |scope, value|
    scope.where 'family_name LIKE ?', escape_search_term(value)
  end
  
    
  def sort_params_arr
    [[I18n.t(:name), 'name asc'], 
      [I18n.t('activerecord.attributes.person.family_name'), 'family_name asc'],
      [I18n.t('activerecord.attributes.person.gender'), 'gender asc'], 
      [I18n.t('activerecord.attributes.person.status_id'), 'status_id asc']]     
  end 
    
  
  private
  
  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end
end