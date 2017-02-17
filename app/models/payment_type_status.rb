class PaymentTypeStatus < ActiveRecord::Base
  belongs_to :payment_type
  belongs_to :status
  validates :payment_type_id, presence: true
  validates :status_id, presence: true
  
  validates_existence_of :payment_type_id
  validates_existence_of :status_id
  
  validates_uniqueness_of :status_id, scope: [:payment_type_id]
    
end
