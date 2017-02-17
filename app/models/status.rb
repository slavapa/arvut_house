class Status < ActiveRecord::Base
  after_save :reset_cache_references
  after_destroy :reset_cache_references
  has_many :payment_type_statuses , :dependent => :restrict_with_error 
  has_many :payment_types, through: :payment_type_statuses
  has_many :people , :dependent => :restrict_with_error 
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
   
   
   private
   def reset_cache_references
     Person.reset_status_array()     
   end
    
end
