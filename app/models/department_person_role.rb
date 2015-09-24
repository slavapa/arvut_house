class DepartmentPersonRole < ActiveRecord::Base
  belongs_to :department
  belongs_to :person
  belongs_to :role
  
  validates :department_id, presence: true
  validates :person_id, presence: true
  validates :role_id, presence: true
  
  
  validates_existence_of :department_id
  validates_existence_of :person_id
  validates_existence_of :role_id
  
  validates_uniqueness_of :department_id, scope: [:person_id, :role_id]
  
  validate :person_full_name_validation
  
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
  
  @is_person_full_name_not_valid = false
  def person_full_name_validation
    # if @person_full_name == person_full_name_was
    #   errors.add(:person_full_name, I18n.t("errors.messages.invalid"))
    # end
    
    #if person_id != person_id_was
    if @person_full_name &&  @person_full_name != person_full_name
      if person_id != person_id_was
        errors.add(:person_full_name, I18n.t("errors.messages.invalid"))
      end
    end
    #end
    # if @is_person_full_name_not_valid 
    #   errors.add(:person_full_name, I18n.t("errors.messages.invalid"))
    # end
  end
   
  #def person_full_name=(full_name)
    # user = Person.find_by_name(full_name)
    # if user
    #   self.person_id = user.id
    # else
    #  errors[:person_id] << "Invalid name entered"
    # end
    #errors.add(:person_id, "Invalid name entered")
    #EventType.find_by_name("SlTest123")
    #person_id=1
    #@person_id=1
  #end
  
  attr_accessor :person_full_name
  
  # def person_full_name=(value)
  #   # user = Person.find_by_full_name(value).first
  #   # if user
  #   #   @new_person_id = user.id
  #   # else
  #   #   @is_person_full_name_not_valid = true
  #   # end
  #   #super(value)
  # end
  
  # def person_id=(value)
  #   if  @new_person_id.nil?
  #     super(value)
  #   else
  #     super(@new_person_id)
  #   end
  # end
 
 
  def person_full_name
    if person_id && !person_name.nil?
      "#{person_name} #{person_family_name}"
        # if defined?(person_name) && !person_name.nil?
        #   "#{person_name} #{person_family_name}"
        # else
        #   #{person.name} #{person.family_name}"
        # end
    end
  end
  

  
  
  protected
  private
end
