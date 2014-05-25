class Language < ActiveRecord::Base
  has_many :person_languages, :dependent => :restrict_with_error 
  has_many :people, through: :person_languages
  
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
      
  validates :code, presence: true, length: { maximum: 2 },
    uniqueness: { case_sensitive: false } 
end
