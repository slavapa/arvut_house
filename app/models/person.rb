class Person < ActiveRecord::Base
  before_save :normalize_blank_values
  has_many :person_event_relationships, dependent: :destroy
  has_many :events, through: :person_event_relationships 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 60 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }, if: lambda { |m| m.password.present? }

  before_save { email.downcase! if  email.present?}
  before_create :create_remember_token
   
  has_secure_password validations: false
  validates :password, length: { minimum: 6 }, if: lambda { |m| m.password.present? }
  validates_confirmation_of :password, if: lambda { |m| m.password.present? }
    
  def gender_arr
    @gender_arr = [['', nil], ['Male', '1'], ['Female', '2']]    
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
