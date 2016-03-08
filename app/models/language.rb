class Language < ActiveRecord::Base
  after_save :reset_cache_references
  has_many :person_languages, :dependent => :restrict_with_error 
  has_many :people, through: :person_languages
  
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false } 
     
  VALID_LANG_REGEX = /\A[a-z][a-z]\z/   
  validates :code, presence: true, length: { maximum: 2 },
    uniqueness: { case_sensitive: false }, format: { with: VALID_LANG_REGEX ,
    message: I18n.t(:lang_code_val) }
    
          
  def languages_array
    Language.languages_array 
  end 
          
  def language_name_array
    Language.language_name_array 
  end   
  
  def self.languages_array
    @@languages_array ||= Language.all.map { |lang| [lang.name, lang.id] }#.unshift(['', nil])
  end 
   
  def self.language_name_array
    @@language_name_array ||= Hash[Language.pluck(:id, :name)]
  end 
  
  def self.reset_languages_array
    @@languages_array = nil
    @@language_name_array = nil
  end 
  
  
  private
  def reset_cache_references
    Language.reset_languages_array()     
  end
end
