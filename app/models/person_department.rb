class PersonDepartment < ActiveRecord::Base
  belongs_to :person
  belongs_to :department
  validates :person_id, presence: true
  validates :department_id, presence: true
  validates_existence_of :person_id
  validates_existence_of :department_id
  
end
