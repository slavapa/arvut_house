class AddForeignkeyToPersonRoles < ActiveRecord::Migration
    def up
    execute <<-SQL
      ALTER TABLE person_roles
      ADD CONSTRAINT fk_person_roles_roles
      FOREIGN KEY (role_id)
      REFERENCES roles(id) 
      ON DELETE RESTRICT
    SQL
    
    execute <<-SQL
      ALTER TABLE person_roles
      ADD CONSTRAINT fk_person_roles_people
      FOREIGN KEY (person_id)
      REFERENCES people(id) 
      ON DELETE CASCADE
    SQL
  end
  
  def down
    execute <<-SQL
      ALTER TABLE person_roles
      DROP CONSTRAINT fk_person_roles_roles
    SQL
    
    execute <<-SQL
      ALTER TABLE person_roles
      DROP CONSTRAINT fk_person_roles_people
    SQL
    
  end
end
