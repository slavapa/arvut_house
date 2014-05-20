class CreatePersonEventRelationships < ActiveRecord::Migration
  def change
    create_table :person_event_relationships do |t|
      t.references :person, index: true, null: false
      t.references :event, index: true, null: false

      t.timestamps
    end
    
    add_index :person_event_relationships, [:person_id, :event_id], unique: true
  end
end
