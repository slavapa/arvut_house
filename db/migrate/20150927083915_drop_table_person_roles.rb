class DropTablePersonRoles < ActiveRecord::Migration
  def change
     drop_table :person_roles do |t|
      t.references :person, index: true
      t.references :role, index: true

      t.timestamps
    end
   
  end
end
