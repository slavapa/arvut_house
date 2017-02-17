class PaymentTypeStatus < ActiveRecord::Base
  belongs_to :paymet_type
  belongs_to :status
  validates :payment_type_id, presence: true
  validates :status_id, presence: true
end
