# encoding: utf-8
class PaymentSearch
  include SearchObject.module(:model, :sorting, :will_paginate)
  
  scope { Payment.all }
  
  per_page 30
  
  sort_by :payment_type_id, :payment_date, :description
  
  option :payment_type_id
  
  
  option :payment_date_after do |scope, value|
    date = parse_date value
    scope.where('DATE(payment_date) >= ?', date) if date.present?
  end

  option :payment_date_before do |scope, value|
    date = parse_date value
    scope.where('DATE(payment_date) <= ?', date) if date.present?
  end
  
  option :description do |scope, value|
    scope.where 'description LIKE ?', escape_search_term(value) if is_not_nil_empty?(value)
  end
  
    
  def sort_params_arr
    [
      ["#{I18n.t('activerecord.attributes.payment.payment_date')} #{I18n.t('asc')}", 'payment_date asc'],
      ["#{I18n.t('activerecord.attributes.payment.payment_date')} #{I18n.t('desc')}", 'payment_date desc']      
    ]     
  end 
  
  def initialize(filters = {}, page = 1)
    filters = Hash.new if filters.nil?
    filters['sort'] = 'payment_date desc' unless filters.has_key?('sort') 
    
    # if Rails.env.test?#TODO: Rspec Test doesn't work. Check how to reslove this for Rspec
      # super filters
    # else
      super filters, page      
    # end
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