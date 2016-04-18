class Person < ActiveRecord::Base
  acts_as_xlsx
  before_save :normalize_blank_values
  before_save { email.downcase! if  email.present?}
  before_save { email_2.downcase! if  email_2.present?}
  after_initialize :populate_default_values
  before_create :create_remember_token
  
  
  validates :car_number,  length: { maximum: 60 }
  validates :area,  length: { maximum: 60 }
  validates :name, presence: true, length: { maximum: 60 }
  validates :family_name,  length: { maximum: 60 }
  validates :phone_mob,  length: { maximum: 60 }
  validates :gender,  inclusion: { in: [nil, 1, 2], 
    message: "%{value} is not a valid.The valid values are: 1-#{I18n.t(:male)}, 2-#{I18n.t(:female)}" }, 
              if: lambda { |p| p.gender.present? }
  
  validates :id_card_number,  length: { in: 8..9 }, if: lambda { |m| m.id_card_number.present? }
  validates :org_relation_status_id, presence: true
  validates :org_relation_status, presence: true
  
  belongs_to :language
  belongs_to :status
  belongs_to :org_relation_status
  belongs_to :visitor_status
  
  has_many :payments, through: :person_payments
  has_many :person_payments, dependent: :destroy
  
  has_many :languages, through: :person_languages
  has_many :person_languages, dependent: :destroy
  
  has_many :department_person_roles, dependent: :destroy
  has_many :roles, through: :department_person_roles
  has_many :departments, through: :department_person_roles
  
  has_many :person_event_relationships, dependent: :destroy
  has_many :events, through: :person_event_relationships 
  has_many :event_types, through: :events
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }, if: lambda { |p| p.password.present? || p.email.present? },
            length: { maximum: 60 }
            
  validates :email_2, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }, length: { maximum: 60 }, 
            if: lambda { |p| p.email_2.present? }   
            
  has_secure_password validations: false
  validates :password, length: { minimum: 6 }, if: lambda { |p| p.password.present? }
  validates_confirmation_of :password, if: lambda { |p| p.password.present? }
  
  
  scope :person_left_outer_event, lambda { |event_id|
    joins("left outer join person_event_relationships 
            on people.id=person_event_relationships.person_id 
            and person_event_relationships.event_id = #{event_id}").
            select("*, people.id As id, 
            person_event_relationships.id As person_event_relationships_id")
  }   
  
  scope :person_left_outer_payment, lambda { |payment_id|
    joins("left outer join person_payments 
            on people.id=person_payments.person_id 
            and person_payments.payment_id = #{payment_id}").
            select("*, people.id As id, person_payments.id As person_payments_id")
  } 
  
  
  scope :find_by_full_name, 
    lambda { |name| 
      where("(people.name || ' ' || people.family_name) = ?", name)
  }
  
  scope :member_group,  -> { where(org_relation_status_id: [1]) }
  scope :guest_group,  -> { where(org_relation_status_id: [2]) }
  
  def is_language_exists?(language)
    !person_languages.where(language_id: language.id).empty?
  end
  
  def add_language!(language)
    !person_languages.create!(language_id: language.id)     
  end
  
  def remove_language!(language) 
    !person_languages.find_by(language_id: language.id).destroy    
  end  
        
  def statuses_array
    Person.statuses_array 
  end   
  def self.statuses_array
    @@statuses_array ||= Status.all.map { |stat| [stat.name, stat.id] }.unshift(['', nil])
  end 
  def self.reset_status_array
    @@statuses_array = nil
  end  
  def status_name
    statuses_array[status_id][0] unless status_id.nil? 
  end 
    
  def self.gender_arr
    [['', nil], [I18n.t(:male), 1], [I18n.t(:female), 2]]     
  end    
  def gender_arr
    Person.gender_arr     
  end  
  def gender_name    
      gender_arr[gender][0] unless gender.nil?
  end
    
  def self.family_status_arr
    [['', nil], [I18n.t(:single), 1], [I18n.t(:married), 2],
                            [I18n.t(:divorced), 3], [I18n.t(:widower), 4]]     
  end   
  def family_status_arr
    Person.family_status_arr  
  end  
  def family_status_name
    family_status_arr[family_status][0] unless family_status.nil?  
  end
    
  def self.car_owner_arr
    [['', nil], [I18n.t(:private), 1], [I18n.t(:commercial), 2]]     
  end  
  def car_owner_arr
    Person.car_owner_arr     
  end  
  def car_owner_name
    car_owner_arr[car_owner][0] unless car_owner.nil?    
  end
    
  def self.computer_knowledge_arr
    @@computer_knowledge_arr = [['', nil], [I18n.t(:weak), 1], [I18n.t(:usual), 2], 
                            [I18n.t(:advanced), 3]]     
  end   
  def computer_knowledge_arr
    Person.computer_knowledge_arr
  end  
  def computer_knowledge_name
    computer_knowledge_arr[computer_knowledge][0] unless computer_knowledge.nil? 
  end
  
  def Person.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Person.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def merge_payment_attr(person_payment)
    self.class_eval do
      attr_accessor :person_payments_id
      attr_accessor :amount
    end
     
    self.person_payments_id = person_payment.id
    self.amount =  person_payment.amount
    self
  end
  
   
  def is_guest?
    org_relation_status_id == OrgRelationStatus::GUEST
  end 
  
  def is_friend?
    org_relation_status_id == OrgRelationStatus::FRIEND
  end
   
  def language_name    
      Language.language_name_array[language_id] unless language_id.nil? 
  end
  
    
private
# http://stackoverflow.com/questions/7202319/rails-force-empty-string-to-null-in-the-database
  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end
  def create_remember_token
    self.remember_token = Person.hash(Person.new_remember_token)
  end
  
  def populate_default_values
    if self.new_record?
      self.org_relation_status_id = OrgRelationStatus::FRIEND
    end
  end
end
