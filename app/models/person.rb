class Person < ActiveRecord::Base
  has_many :person_event_relationships, dependent: :destroy
  has_many :events, through: :person_event_relationships 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 60 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  before_save { email.downcase! }
  before_create :create_remember_token
   
  has_secure_password
  validates :password, length: { minimum: 6 }
  
  
  def Person.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Person.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
    
private

  def create_remember_token
    self.remember_token = Person.hash(Person.new_remember_token)
  end
end
