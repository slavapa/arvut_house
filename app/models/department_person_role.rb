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
   
  def departments_array
    if defined?(@@departments_array).nil? || @@departments_array.nil?
      @@departments_array = Hash.new
      Department.all.map do |department| 
        @@departments_array[department.id] = department.name
      end
    end
    @@departments_array
  end 

  def self.reset_departments_array
    @@departments_array = nil
  end  
  
  def department_name_by_hash
    departments_array[department_id] 
  end
  
  def roles_array
    if defined?(@@roles_array).nil? || @@roles_array.nil?
      @@roles_array = Hash.new
      Role.all.map do |role| 
        @@roles_array[role.id] = role.name
      end
    end
    @@roles_array
  end 

  def self.reset_roles_array
    @@roles_array = nil
  end  
  
  def role_name_by_hash
    roles_array[role_id] 
  end

end
