class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name, null: false, limit: 60
      t.string :description

      t.timestamps
    end
    add_index :departments, :name, unique: true
  end
end
