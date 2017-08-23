class PaymentType < ActiveRecord::Base 
  has_many :payment_type_statuses , dependent: :destroy
  has_many :statuses, through: :payment_type_statuses 
  has_many :payments , :dependent => :restrict_with_error
  has_many :person_default_payments , dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
  validates :frequency, presence: true,  
    inclusion: { in: [nil, 1, 2, 3, 4, 5], 
    message: I18n.t(:validates_inclusion, value: "%{value}", 
      valid_values: "1-#{I18n.t(:general)}, 2-#{I18n.t(:daily)}, 
3-#{I18n.t(:weekly)}, 4-#{I18n.t(:monthly)}, 5-#{I18n.t(:annually)}") }
  
  validates :amount, :numericality => { :greater_than => 0 }, 
    :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
    allow_nil: true
       
  def self.frequency_arr
    [
      ['', nil], [I18n.t(:general), 1],
      [I18n.t(:daily), 2],
      [I18n.t(:weekly), 3],
      [I18n.t(:monthly), 4],
      [I18n.t(:annually), 5],
      ['Not Valid', 6]       
    ]     
  end 
  
  def frequency_arr
    PaymentType.frequency_arr
  end
  
  def frequency_name
    frequency_arr[frequency][0] unless frequency.nil?  
  end
   
  def is_perosn_exists?(other_person)
    !person_default_payments.where(person_id: other_person.id).empty?
  end
  
  def add_person!(person)
    person_default_payments.create(person_id: person.id, amount: self.amount)     
  end
  
  def remove_person!(person) 
    person_default_payments.find_by(person_id: person.id).destroy    
  end 
  
   
  def person_default_payments_cach
    @app_setup_cach ||= Hash.new
  end
   
  def default_payment_person(person)
    person_default_payments_cach[person.id] ||= 
        person_default_payments.find_by(person_id: person.id)
  end
  
end
