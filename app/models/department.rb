class Department < ActiveRecord::Base
  has_many :person_departmens, :dependent => :restrict_with_error 
  has_many :people, through: :person_departments
  
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
    
  validates :description, length: { maximum: 255 }
  
end
