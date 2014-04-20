class CreatePersonEventRelationships < ActiveRecord::Migration
  def change
    create_table :person_event_relationships do |t|
      t.integer :person_id
      t.integer :event_id

      t.timestamps
    end
    add_index :person_event_relationships, :person_id
    add_index :person_event_relationships, :event_id
    add_index :person_event_relationships, [:person_id, :event_id], unique: true
  end
end
