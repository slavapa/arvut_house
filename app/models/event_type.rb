class EventType < ActiveRecord::Base     
  #before_destroy :can_destroy_event_type?
  has_many :events , :dependent => :restrict_with_error 
  validates :name, presence: true, length: { maximum: 60 },
    uniqueness: { case_sensitive: false }
 
   
    # def can_destroy_event_type?
      # if self.events.empty?
      # else
        # errors.add :base, "Cannot delete Event Type as it already in use by events"
        # #raise "Cannot delete booking with payments" 
        # false
      # end
    # end
end
