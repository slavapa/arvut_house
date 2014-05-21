class Person < ActiveRecord::Base
  before_save :normalize_blank_values
  before_save { email.downcase! if  email.present?}
  before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 60 }
  validates :family_name,  length: { maximum: 60 }
  validates :phone_mob,  length: { maximum: 60 }
  validates :gender,  inclusion: { in: [nil, 1, 2], 
    message: "%{value} is not a valid.The valid values are: 1-#{I18n.t(:male)}, 2-#{I18n.t(:female)}" }, 
              if: lambda { |p| p.gender.present? }
  
  validates :id_card_number,  length: { is: 9 }, if: lambda { |m| m.id_card_number.present? }
  has_many :person_event_relationships, dependent: :destroy
  has_many :events, through: :person_event_relationships 
  has_many :event_types, through: :events
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }, if: lambda { |p| p.password.present? },
            length: { maximum: 60 }   
  has_secure_password validations: false
  validates :password, length: { minimum: 6 }, if: lambda { |p| p.password.present? }
  validates_confirmation_of :password, if: lambda { |p| p.password.present? }
  # default_scope -> { order('name, family_name ASC') }
    
  def gender_arr
    @gender_arr = [['', nil], [I18n.t(:male), 1], [I18n.t(:female), 2]]     
  end
    
  def family_status_arr
    @family_status_arr = [['', nil], [I18n.t(:single), 1], [I18n.t(:married), 2],
                            [I18n.t(:divorced), 3], [I18n.t(:widower), 4]]     
  end
  
  def Person.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Person.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
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
end
