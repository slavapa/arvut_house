class Event < ActiveRecord::Base
  has_one :event_types
  has_many :person_event_relationships, dependent: :destroy
  has_many :people, through: :person_event_relationships
  validates :event_date, presence: true, uniqueness: { case_sensitive: false, scope: :event_date }
  default_scope -> { order('event_date DESC, event_type_id ASC') }
  
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
  
  def event_types_name
    unless event_type_id.nil?
      event_types_array[event_type_id-1][0]
    end
  end
  
  def event_types_array
    @event_types_array ||= 
      EventType.all.map { |event_type| [event_type.name, event_type.id] }
  end  
end
