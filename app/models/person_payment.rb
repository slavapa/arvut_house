class PersonPayment < ActiveRecord::Base
  belongs_to :person
  belongs_to :payment
  validates :person_id, presence: true
  validates :payment_id, presence: true
  validates_existence_of :person_id
  validates_existence_of :payment_id
end
