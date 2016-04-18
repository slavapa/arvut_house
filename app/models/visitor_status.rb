class VisitorStatus < ActiveRecord::Base
  after_save :reset_cache_references
  
  has_many :people, :dependent => :restrict_with_error 
  
  validates :name, presence: true, length: { maximum: 254 },
    uniqueness: { case_sensitive: false } 
    
  validates :description, length: { maximum: 254 }
       
  def statuses_array
    VisitorStatus.statuses_array 
  end   
  def self.statuses_array
    @@statuses_array ||= VisitorStatus.all.map { |stat| [stat.name, stat.id] }#.unshift(['', nil])
  end 
  def self.reset_status_array
    @@statuses_array = nil
  end       
   
  private
  def reset_cache_references
    VisitorStatus.reset_status_array()     
  end
  
end
