class AddForeignkeyToPersonLanguages < ActiveRecord::Migration
    def up
    execute <<-SQL
      ALTER TABLE person_languages
      ADD CONSTRAINT fk_person_languages_languages
      FOREIGN KEY (language_id)
      REFERENCES languages(id) 
      ON DELETE RESTRICT
    SQL
    
    execute <<-SQL
      ALTER TABLE person_languages
      ADD CONSTRAINT fk_person_languages_people
      FOREIGN KEY (person_id)
      REFERENCES people(id) 
      ON DELETE CASCADE
    SQL
  end
  
  def down
    execute <<-SQL
      ALTER TABLE person_languages
      DROP CONSTRAINT fk_person_languages_languages
    SQL
    
    execute <<-SQL
      ALTER TABLE person_languages
      DROP CONSTRAINT fk_person_languages_people
    SQL
    
  end
end
