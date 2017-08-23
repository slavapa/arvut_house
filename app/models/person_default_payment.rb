class PersonDefaultPayment < ActiveRecord::Base
  belongs_to :person
  belongs_to :payment_type
  
  validates :person_id, presence: true
  validates :payment_type_id, presence: true
  
  validates :amount, :numericality => { :greater_than => 0 }, 
    :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
    allow_nil: true
    
end
