class PersonLanguage < ActiveRecord::Base
  belongs_to :language
  belongs_to :person
end
