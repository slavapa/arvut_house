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
    
  option :phone_mob do |scope, value|
    scope.where 'phone_mob LIKE ?', escape_search_term(value)
  end
  
    
  def sort_params_arr
    [
      ["#{I18n.t(:name)} #{I18n.t('a-z')}", 'name asc'],  
      ["#{I18n.t(:name)} #{I18n.t('z-a')}", 'name desc'],
      ["#{I18n.t('activerecord.attributes.person.family_name')} #{I18n.t('a-z')}", 'family_name asc'],
      ["#{I18n.t('activerecord.attributes.person.family_name')} #{I18n.t('z-a')}", 'family_name desc']      
    ]     
  end 
  
  def initialize(filters = {}, page = 1)
    filters = Hash.new if filters.nil?
    filters['sort'] = 'name asc' unless filters.has_key?('sort') 
    super filters, page
  end  
  
  private
  
  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end
end