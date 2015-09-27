class DropPersonDepartments < ActiveRecord::Migration
  def change
    drop_table :person_departments do |t|
      t.references :person, index: true
      t.references :department, index: true

      t.timestamps
    end
  end
end
