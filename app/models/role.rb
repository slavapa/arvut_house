class Role < ActiveRecord::Base 
  has_many :person_roles, :dependent => :restrict_with_error 
  has_many :people, through: :person_roles
  
  validates :name, presence: true, length: { maximum: 254 },
    uniqueness: { case_sensitive: false } 
    
end
