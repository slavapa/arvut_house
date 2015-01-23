class DropPaymetTypesTable < ActiveRecord::Migration  
  def up
    drop_table :paymet_types
  end

  def down    
    create_table :paymet_types do |t|
      t.string :name, limit: 60, null: false
      t.integer :frequency

      t.timestamps
    end
    add_index :paymet_types, :name
    add_index :paymet_types, :frequency
  end
end
