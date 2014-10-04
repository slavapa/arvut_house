# encoding: utf-8
class EventSearch
  include SearchObject.module(:model, :sorting, :will_paginate)
  
  scope { Event.all }
  
  per_page 30
  
  sort_by :event_type_id, :event_date, :description
  
  option :event_type_id
  
  
  option :event_date_after do |scope, value|
    date = parse_date value
    scope.where('DATE(event_date) >= ?', date) if date.present?
  end

  option :event_date_before do |scope, value|
    date = parse_date value
    scope.where('DATE(event_date) <= ?', date) if date.present?
  end
  
  option :description do |scope, value|
    scope.where 'description LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
  
    
  def sort_params_arr
    [
      ["#{I18n.t('activerecord.attributes.event.event_date')} #{I18n.t('asc')}", 'event_date asc'],
      ["#{I18n.t('activerecord.attributes.event.event_date')} #{I18n.t('desc')}", 'event_date desc']      
    ]     
  end 
  
  def initialize(filters = {}, page = 1)
    filters = Hash.new if filters.nil?
    filters['sort'] = 'event_date desc' unless filters.has_key?('sort') 
    
    if Rails.env.test?#TODO: Rspec Test doesn't work. Check how to reslove this for Rspec
      super filters
    else
      super filters, page      
    end
  end  
  
  private
  
  def parse_date(date)
    Date.strptime(date, '%Y-%m-%d') rescue nil
  end
  
  def is_not_nil_empty?(value)
    !value.nil? && !value.empty? && value.strip.length > 0
  end
  
  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end
end