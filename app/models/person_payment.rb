class PersonPayment < ActiveRecord::Base
  belongs_to :person
  belongs_to :payment
  has_one :payment_type, through: :payment
  validates :person_id, presence: true
  validates :payment_id, presence: true
  validates_existence_of :person_id
  validates_existence_of :payment_id
  
  validates :amount, :numericality => { :greater_than => 0 }, 
    :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
    allow_nil: false
    
  validates :default_amount, :numericality => { :greater_than => 0 }, 
    :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
    allow_nil: false
end
