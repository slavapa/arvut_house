class DepartmentPersonRole < ActiveRecord::Base
  belongs_to :department
  belongs_to :person
  belongs_to :role
  
  before_validation :person_full_name_validation
  
  validates :department_id, presence: true
  validates :person_id, presence: true
  validates :role_id, presence: true
  
  validates_existence_of :department_id
  validates_existence_of :person_id
  validates_existence_of :role_id
  
  validates_uniqueness_of :person_id, scope: [:department_id, :role_id], 
    message: ": #{I18n.t("department_person_roles.errors.uniqueness")}"
 
  scope :inner_departments_people_roles, lambda {
    joins("inner join departments on departments.id=department_person_roles.department_id
            inner join people on people.id=department_person_roles.person_id
            inner join roles on roles.id=department_person_roles.role_id").
            select("department_person_roles.*, 
            people.name As person_name, people.family_name As person_family_name, 
            roles.name As role_name,
            departments.name As department_name")
  }
  
  default_scope inner_departments_people_roles
  
  attr_accessor :person_full_name
  
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
  
  def person_full_name_validation
    if @person_full_name &&  @person_full_name != person_full_name
      if person_id == person_id_was
        user = Person.find_by_full_name(@person_full_name).first
        if user
          self.person_id = user.id
        else
          errors.add(:person_full_name, I18n.t("errors.messages.invalid"))
          return false
        end
      end
    end
  end
  
  def person_full_name
    if person_id && has_attribute?('person_name') && !person_name.nil?
      "#{person_name} #{person_family_name}".strip
    end
  end
  
  
  protected
  private
end
