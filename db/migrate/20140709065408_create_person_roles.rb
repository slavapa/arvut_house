 #rails generate model PersonRole person:references role:references
 class CreatePersonRoles < ActiveRecord::Migration
  def change
    create_table :person_roles do |t|
      t.references :person, index: true
      t.references :role, index: true

      t.timestamps
    end
    
    add_index :person_roles, ["person_id", "role_id"], unique: true
  end
end
