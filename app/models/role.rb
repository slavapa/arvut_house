class Role < ActiveRecord::Base
  after_save :reset_cache_references
  after_destroy :reset_cache_references 
  has_many :department_person_roles, :dependent => :restrict_with_error 
  has_many :people, through: :department_person_roles
  has_many :departments, through: :department_person_roles
  
  validates :name, presence: true, length: { maximum: 254 },
    uniqueness: { case_sensitive: false } 
    
   private
   def reset_cache_references
     DepartmentPersonRole.reset_roles_array 
   end 
end
