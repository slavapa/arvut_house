class PaymentType < ActiveRecord::Base 
  has_many :payments , :dependent => :restrict_with_error
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
end
