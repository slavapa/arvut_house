class CreateApplicationSetupTypes < ActiveRecord::Migration
  def change
    create_table :application_setup_types do |t|
      t.integer :code_id, null: false
      t.string :name, limit: 60, null: false
      t.string :description

      t.timestamps
    end
    add_index :application_setup_types, :code_id, unique: true
    add_index :application_setup_types, :name, unique: true
  end
end
