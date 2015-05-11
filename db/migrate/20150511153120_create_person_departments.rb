class CreatePersonDepartments < ActiveRecord::Migration
  def change
    create_table :person_departments do |t|
      t.references :person, index: true
      t.references :department, index: true

      t.timestamps
    end
    add_index :person_departments, ["person_id", "department_id"], unique: true
  end
end
