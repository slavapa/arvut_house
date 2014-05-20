class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.date :event_date, index: true, null: false
      t.references :event_type, index: true, null: false

      t.timestamps
    end  
    add_index :events, [:event_type_id, :event_date], unique: true  
  end
end
