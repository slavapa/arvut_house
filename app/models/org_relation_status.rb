class OrgRelationStatus < ActiveRecord::Base
  # after_save :reset_cache_references
  # after_destroy :reset_cache_references
  
  # has_many :people , :dependent => :restrict_with_error 
  # validates :name, presence: true, length: { maximum: 60 },
  #   uniqueness: { case_sensitive: false } 
    
  # validates :description, length: { maximum: 254 }
        
  # def statuses_array
  #   OrgRelationStatus.statuses_array 
  # end   
  # def self.statuses_array
  #   @@statuses_array ||= OrgRelationStatus.all.map { |stat| [stat.name, stat.id] }.unshift(['', nil])
  # end 
  # def self.reset_status_array
  #   @@statuses_array = nil
  # end 
  
  # def status_name
  #   statuses_array[status_id][0] unless status_id.nil? 
  # end 
  
  
  # private
  # def reset_cache_references
  #   Person.reset_status_array()     
  # end
    
end
