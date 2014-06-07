# encoding: utf-8
class PersonSearch
  include SearchObject.module(:model, :sorting, :will_paginate)
  
  scope { Person.all.order("name, family_name ASC") }
  
  per_page 30
  
  sort_by :name, :family_name, :gender, :status
  
  option :person_id
  
  option :name do |scope, value|
    scope.where 'name LIKE ?', escape_search_term(value)
  end
  
  option :family_name do |scope, value|
    scope.where 'family_name LIKE ?', escape_search_term(value)
  end
  
  private
  
  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end
end