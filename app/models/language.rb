class Language < ActiveRecord::Base
  has_many :person_languages, :dependent => :restrict_with_error 
  has_many :people, through: :person_languages
  
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
     
  VALID_LANG_REGEX = /\A[a-z][a-z]\z/   
  validates :code, presence: true, length: { maximum: 2 },
    uniqueness: { case_sensitive: false }, format: { with: VALID_LANG_REGEX ,
    message: I18n.t(:lang_code_val) }
  
end
