class PersonEventRelationship < ActiveRecord::Base
  belongs_to :event
  belongs_to :person
  has_one :event_type, through: :event
  validates :person_id, presence: true
  validates :event_id, presence: true
end
