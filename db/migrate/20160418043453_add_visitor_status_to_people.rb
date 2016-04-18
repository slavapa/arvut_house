class AddVisitorStatusToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :visitor_status, index: true
  end
   
  reversible do |dir|
    dir.up do
      Person.update_all org_relation_status_id: 1
    end
    
    dir.down do
    end
  end
  
end
