class PersonLanguage < ActiveRecord::Base
  belongs_to :language
  belongs_to :person
  validates :person_id, presence: true
  validates :language_id, presence: true
  validates_existence_of :person_id
  validates_existence_of :language_id
end
