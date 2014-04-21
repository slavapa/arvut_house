class Event < ActiveRecord::Base
  has_many :person_event_relationships, dependent: :destroy
  has_many :people, through: :person_event_relationships
  validates :event_date, presence: true
  validates :name, presence: true, length: { maximum: 60 }, 
  uniqueness: { case_sensitive: false, scope: :event_date }
  #before_save { name.downcase! }
  default_scope -> { order('event_date DESC, name ASC') }
  
  after_initialize :default_values
  
  def default_values(attributes = {}, options = {})
    self.event_date = Date.today if self.event_date.nil? 
  end
  
  def add_person!(person)
    person_event_relationships.create!(person_id: person.id)     
  end
  
  def remove_person!(person) 
    person_event_relationships.find_by(person_id: person.id).destroy    
  end  
  
  def is_perosn_exists?(other_person)
    person_event_relationships.find_by(person_id: other_person.id)
  end
end
