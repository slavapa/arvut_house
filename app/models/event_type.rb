class EventType < ActiveRecord::Base 
  has_many :events , :dependent => :restrict_with_error 
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
   
end
