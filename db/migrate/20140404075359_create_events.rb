class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, limit: 60
      t.string :description
      t.index("name"), unique: true

      t.timestamps
    end
  end
end
