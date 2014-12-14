class PaymetType < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
  validates :frequency, presence: true
     
  def self.frequency_arr
    [
      ['', nil], [I18n.t(:general), 1],
      [I18n.t(:daily), 2],
      [I18n.t(:weekly), 3],
      [I18n.t(:monthly), 4],
      [I18n.t(:annually), 5]      
    ]     
  end 
  
  def frequency_arr
    PaymetType.frequency_arr
  end
  
  def frequency_name
    frequency_arr[frequency][0] unless frequency.nil?  
  end
end
