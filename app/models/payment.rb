class Payment < ActiveRecord::Base
  acts_as_xlsx
  belongs_to :payment_type
  has_many :person_payments , dependent: :destroy
  has_many :people, through: :person_payments
  validates :payment_date, presence: true
  validates :payment_type_id, presence: true
  validates_existence_of :payment_type_id
  validates_uniqueness_of :payment_date, scope: [:payment_type_id]
  validates :description, length: { maximum: 255 }
  after_initialize :default_values
  
  scope :between_dates, lambda { |start_date, end_date|
    where("payment_date >= ? AND payment_date <= ?", start_date, end_date )
    .order(:payment_date)
  } 
    
  def default_values(attributes = {}, options = {})
    self.payment_date = Date.today if self.payment_date.nil? 
  end
  
  def payment_type_name
    unless payment_type_id.nil?
      payment_type_array[payment_type_id]
    end
  end
   
  def payment_type_array
    if @payment_type_array.nil?
      @payment_type_array = Hash.new
      PaymentType.all.each do |payment_type|
         @payment_type_array[payment_type.id] = payment_type.name
      end
    end
    return @payment_type_array
  end 
  
  def add_person!(person)
    defAmount = get_perosn_default_amount(person)
    
    person_payments.create(person_id: person.id, amount: defAmount, default_amount: defAmount)     
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
    
  def get_is_perosn_payed_val(person)
    if person.payment_id.nil?
      I18n.t("no")
    else
       I18n.t("yes")
    end
  end
    
  def get_perosn_default_amount(person)
    personDefaultPayment = person.person_default_payments.where(payment_type_id: payment_type_id)
    
    if !personDefaultPayment.empty? 
      defAmount = personDefaultPayment[0].amount
    else
      defAmount = payment_type.amount
    end
  end
  
  def is_person_amount_less_than_default(person, sum)
    personDefaultPayment = get_perosn_default_amount(person)
    
    if sum < personDefaultPayment 
      true
    else
      false
    end
  end
end
