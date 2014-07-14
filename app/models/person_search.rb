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
  option :family_status
  option :computer_knowledge
  
  option :name do |scope, value|
    scope.where 'name LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
  
  option :family_name do |scope, value|
    scope.where 'family_name LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
    
  option :phone_mob do |scope, value|
    scope.where 'phone_mob LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
  
  option :area do |scope, value|
    scope.where 'area LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
    
  option :is_present do |scope, value|
    unless @atributes[:event_id].nil?
      if value == '1'
        sql = "(exists (select 'x' from person_event_relationships
                where people.id=person_event_relationships.person_id 
                and person_event_relationships.event_id=#{@atributes[:event_id]}))"
        scope.where sql
      elsif value == '2'
        sql = "(not exists (select 'x' from person_event_relationships
                where people.id=person_event_relationships.person_id 
                and person_event_relationships.event_id=#{@atributes[:event_id]}))"
        scope.where sql
      end
    end
  end
  
    
  def sort_params_arr
    [
      ["#{I18n.t(:name)} #{I18n.t('a-z')}", 'name asc'],  
      ["#{I18n.t(:name)} #{I18n.t('z-a')}", 'name desc'],
      ["#{I18n.t('activerecord.attributes.person.family_name')} #{I18n.t('a-z')}", 'family_name asc'],
      ["#{I18n.t('activerecord.attributes.person.family_name')} #{I18n.t('z-a')}", 'family_name desc'] ,
      ["#{I18n.t('activerecord.attributes.person.area')} #{I18n.t('a-z')}", 'area asc'],
      ["#{I18n.t('activerecord.attributes.person.area')} #{I18n.t('z-a')}", 'area desc']     
    ]     
  end 
  
  def initialize(filters = {}, page = 1, atributes = {})
    @atributes = atributes
    filters = Hash.new if filters.nil?
    filters['sort'] = 'name asc' unless filters.has_key?('sort') 
    super filters, page
  end  
  
  private
  
  def is_not_nil_empty?(value)
    !value.nil? && !value.empty? && value.strip.length > 0
  end
  
  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end
end