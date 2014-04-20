class PersonEventRelationship < ActiveRecord::Base
  belongs_to :event
  belongs_to :person
  validates :person_id, presence: true
  validates :event_id, presence: true
end
