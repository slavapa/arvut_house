class Event < ActiveRecord::Base
  acts_as_xlsx
  belongs_to :event_type, foreign_key: :event_type_id
  #validates :event_types, :presence => true
  has_many :person_event_relationships, dependent: :destroy
  has_many :people, through: :person_event_relationships
  validates :event_date, presence: true, 
    uniqueness: { case_sensitive: false, scope: :event_type_id }
  #default_scope -> { order('event_date DESC, event_type_id ASC') }
  validates :event_type_id, presence: true
  validate :event_type_id_must_exists  
  after_initialize :default_values
  validates :description, length: { maximum: 255 }
  
  scope :between_dates, lambda { |start_date, end_date|
    where("event_date >= ? AND event_date <= ?", start_date, end_date )
    .order(:event_date)
  } 
  
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
    !person_event_relationships.where(person_id: other_person.id).empty?
  end
  
  def is_perosn_ext_exists?(other_person)
    !other_person.person_event_relationships_id.nil?
  end
   
  def get_is_perosn_present_val(person)
    if person.person_event_relationships_id.nil?
      I18n.t("no")
    else
       I18n.t("yes")
    end
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
  
  private
  def event_type_id_must_exists    
    if event_type_id.blank?
      self.errors.add(:event_type, I18n.t(:presence, name: I18n.t('activerecord.models.event_type')))
    else
      if EventType.find_by_id(self.event_type_id).nil?
        self.errors.add(:event_type_id, I18n.t(:existence, name: I18n.t('activerecord.models.event_type')))        
      end      
    end
  end
end
