# rails generate migration event_type_foreignkey_to_events

class EventTypeForeignkeyToEvents < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE events
      ADD CONSTRAINT fk_events_event_types
      FOREIGN KEY (event_type_id)
      REFERENCES event_types(id) 
      ON UPDATE CASCADE ON DELETE RESTRICT
    SQL
    
  end
  
  def down
    execute <<-SQL
      ALTER TABLE events
      DROP CONSTRAINT fk_events_event_types
    SQL
    
  end
end
