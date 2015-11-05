# encoding: utf-8

class CreateApplicationSetups < ActiveRecord::Migration
  def change
    create_table :application_setups do |t|
      t.references :app_setup_type, index: true
      t.string :language_code_id, limit: 5, null: false, index: true
      t.string :code_id, limit: 60, null: false, index: true
      t.string :description
      t.string :str_value, null: false

      t.timestamps
    end
    
     add_index :application_setups, ["language_code_id", "code_id"], unique: true, 
        name: 'index_application_setups_language_code_id_code_id'
    
    reversible do |dir|
      dir.up do
        # execute <<-SQL
        #   ALTER TABLE application_setups
        #   ADD CONSTRAINT fk_application_setups_app_setup_types
        #   FOREIGN KEY (language_code_id)
        #   REFERENCES languages(code) 
        #   ON DELETE RESTRICT
        # SQL
        
        ApplicationSetup.create app_setup_type_id: 1, language_code_id: 'en', 
          code_id: 'organization_name', description: 'Organization name', 
          str_value: 'Haifa Arvut House'
          
        ApplicationSetup.create app_setup_type_id: 1, language_code_id: 'he', 
          code_id: 'organization_name', description: 'Organization name', 
          str_value: 'בית ערבות חיפה'
          
        ApplicationSetup.create app_setup_type_id: 1, language_code_id: 'ru', 
          code_id: 'organization_name', description: 'Organization name', 
          str_value: 'Хайфский дом Арвута'

      end
      
      dir.down do
        # execute <<-SQL
        #   ALTER TABLE application_setups
        #   DROP CONSTRAINT fk_application_setups_app_setup_types
        # SQL
      end
    end
  end
end
