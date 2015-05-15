class Payment < ActiveRecord::Base
  belongs_to :payment_type
  has_many :person_payments , dependent: :destroy
  has_many :people, through: :person_payments
  validates :payment_date, presence: true
  validates :payment_type_id, presence: true
  validates_existence_of :payment_type_id
  validates_uniqueness_of :payment_date, scope: [:payment_type_id]
  validates :description, length: { maximum: 255 }
  after_initialize :default_values
    
  def default_values(attributes = {}, options = {})
    self.payment_date = Date.today if self.payment_date.nil? 
  end
  
  def payment_type_name
    unless payment_type_id.nil?
      payment_type_array[payment_type_id-1][0]
    end
  end
   
  def payment_type_array
    @payment_type_array ||= 
      PaymentType.all.map { |payment_type| [payment_type.name, payment_type.id] }
  end 
  
  def add_person!(person)
    person_payments.create!(person_id: person.id, amount: payment_type.amount)     
  end
  
  def remove_person!(person) 
    person_payments.find_by(person_id: person.id).destroy    
  end  
  
  def is_perosn_exists?(other_person)
    !person_payments.where(person_id: other_person.id).empty?
  end
  
  def is_perosn_ext_exists?(other_person)
    !other_person.payment_id.nil?
  end
  
end
