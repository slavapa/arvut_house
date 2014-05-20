#rails generate migration add_foreignkey_to_person_event_relationships
class AddForeignkeyToPersonEventRelationships < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE person_event_relationships
      ADD CONSTRAINT fk_person_event_relationships_events
      FOREIGN KEY (event_id)
      REFERENCES events(id) 
      ON DELETE CASCADE
    SQL
    
    execute <<-SQL
      ALTER TABLE person_event_relationships
      ADD CONSTRAINT fk_person_event_relationships_people
      FOREIGN KEY (person_id)
      REFERENCES people(id) 
      ON DELETE CASCADE
    SQL
  end
  
  def down
    execute <<-SQL
      ALTER TABLE person_event_relationships
      DROP CONSTRAINT fk_person_event_relationships_events
    SQL
    
    execute <<-SQL
      ALTER TABLE person_event_relationships
      DROP CONSTRAINT fk_person_event_relationships_people
    SQL
    
  end
end
