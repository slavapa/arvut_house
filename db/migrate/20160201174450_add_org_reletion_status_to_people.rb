class AddOrgReletionStatusToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :org_relation_statuse, index: true
    
     
    reversible do |dir|
      dir.up do
        Person.update_all org_relation_statuse_id: 1
      end
      dir.down do
      end
    end
  end
  
end
