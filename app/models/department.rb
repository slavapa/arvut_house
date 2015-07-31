class Department < ActiveRecord::Base
  after_save :reset_cache_references
  after_destroy :reset_cache_references
  has_many :person_departmens
  has_many :people, through: :person_departments
  
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
    
  validates :description, length: { maximum: 255 }
  
  
   private
   def reset_cache_references
     DepartmentPersonRole.reset_departments_array 
   end
   
end
