# encoding: utf-8
class PersonPaymentSearch
  include SearchObject.module(:model, :sorting, :will_paginate)
    
  def self.set_payment_id(value)
    @@payment_id = value
  end
  
  scope { Person.person_left_outer_payment (@@payment_id) }
  
  per_page 30
  
  sort_by 'area', 'department', 'name', 'family_name', 'gender', 'status_id', 'person_payments.payment_id', 'ten'
  
  option :person_id  
  option :gender 
  option :status_id
  option :family_status
  option :computer_knowledge
  option :org_relation_status_id
  option :ten
  
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
     
  option :department do |scope, value|
    scope.where 'department LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
   
  option :is_paid do |scope, value|
    unless @atributes[:payment_id].nil?
      if value == '1'
        sql = "(exists (select 'x' from person_payments
                where people.id = person_payments.person_id 
                and person_payments.payment_id=#{@atributes[:payment_id]}))"
        scope.where sql
      elsif value == '2'
        sql = "(not exists (select 'x' from person_payments
                where people.id = person_payments.person_id 
                and person_payments.payment_id=#{@atributes[:payment_id]}))"
        scope.where sql
      end
    end
  end
  
    
  def sort_params_arr
    [
      ["#{I18n.t(:name)} #{I18n.t('a-z')}", 'name asc'],  
      ["#{I18n.t(:name)} #{I18n.t('z-a')}", 'name desc'],
      ["#{I18n.t('activerecord.attributes.person.family_name')} #{I18n.t('a-z')}", 'family_name asc'],
      ["#{I18n.t('activerecord.attributes.person.family_name')} #{I18n.t('z-a')}", 'family_name desc'],
      ["#{I18n.t('activerecord.attributes.person.area')} #{I18n.t('a-z')}", 'area asc'],
      ["#{I18n.t('activerecord.attributes.person.area')} #{I18n.t('z-a')}", 'area desc'],
      ["#{I18n.t('activerecord.attributes.person.department')} #{I18n.t('a-z')}", 'department asc'],
      ["#{I18n.t('activerecord.attributes.person.department')} #{I18n.t('z-a')}", 'department desc'],
      ["#{I18n.t('events.edit.present')} #{I18n.t('up')}", 'person_event_relationships.event_id asc'],  
      ["#{I18n.t('events.edit.present')} #{I18n.t('down')}", 'person_event_relationships.event_id desc']          
    ]     
  end 
  
  def initialize(filters = {}, page = 1, atributes = {})
    @atributes = atributes
    filters = Hash.new if filters.nil?
    filters['sort'] = 'name asc' unless filters.has_key?('sort') 
    filters['org_relation_status_id'] = OrgRelationStatus::FRIEND unless filters.has_key?('org_relation_status_id') 
    
    # if Rails.env.test?#TODO: Rspec Test doesn't work. Check how to reslove this for Rspec
      # super filters
    # else
      super filters, page      
    # end
  end  
  
  private
  
  def get_event_id
    return @atributes[:event_id]
  end
  
  def is_not_nil_empty?(value)
    !value.nil? && !value.empty? && value.strip.length > 0
  end
  
  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end
end