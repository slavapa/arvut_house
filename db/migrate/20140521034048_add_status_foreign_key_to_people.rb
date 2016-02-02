#rails generate migration add_status_foreign_key_to_people
class AddStatusForeignKeyToPeople < ActiveRecord::Migration  
  # def up
  #   execute <<-SQL
  #     ALTER TABLE people
  #     ADD CONSTRAINT fk_people_statuses
  #     FOREIGN KEY (status_id)
  #     REFERENCES statuses(id) 
  #     ON DELETE RESTRICT
  #   SQL
    
  # end
  
  # def down
  #   execute <<-SQL
  #     ALTER TABLE people
  #     DROP CONSTRAINT fk_people_statuses
  #   SQL
    
  # end
end
