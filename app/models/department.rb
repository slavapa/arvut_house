class Department < ActiveRecord::Base
  after_save :reset_cache_references
  after_destroy :reset_cache_references
  has_many :department_person_roles, :dependent => :restrict_with_error
  has_many :people, through: :department_person_roles
  has_many :roles, through: :department_person_roles
  
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
    
  validates :description, length: { maximum: 255 }
  
  
   private
   def reset_cache_references
     ApplicationSetup.reset_departments_array 
   end
   
end
