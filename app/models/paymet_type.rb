class PaymetType < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
  validates :frequency, presence: true
end
