class EventType < ActiveRecord::Base
  has_many :events
  validates :name, presence: true, length: { maximum: 60 }
end
