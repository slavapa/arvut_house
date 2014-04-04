class Event < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 60 }, 
  uniqueness: { case_sensitive: false }
  before_save { name.downcase! }
  
end
