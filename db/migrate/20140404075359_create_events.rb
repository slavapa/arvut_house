class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, limit: 60
      t.string :description

      t.timestamps
    end
  end
  add_index :events, :name, unique: true
end
