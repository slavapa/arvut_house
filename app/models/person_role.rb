class PersonRole < ActiveRecord::Base
  belongs_to :person
  belongs_to :role
  validates :person_id, presence: true
  validates :role_id, presence: true
end
