class DepartmentPersonRole < ActiveRecord::Base
  belongs_to :department
  belongs_to :person
  belongs_to :role
  
   
  scope :inner_departments_people_roles, lambda {
    joins("inner join departments on departments.id=department_person_roles.department_id
            inner join people on people.id=department_person_roles.person_id
            inner join roles on roles.id=department_person_roles.role_id").
            select("department_person_roles.*, 
            people.name As person_name, people.family_name As person_family_name, 
            roles.name As role_name,
            departments.name As department_name")
  }  
  
end
