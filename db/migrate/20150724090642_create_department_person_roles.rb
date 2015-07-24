class CreateDepartmentPersonRoles < ActiveRecord::Migration
  def change
    create_table :department_person_roles do |t|
      t.references :department, index: true, null: false
      t.references :person, index: true, null: false
      t.references :role, index: true, null: false
      
      t.timestamps
    end
    add_index :department_person_roles, ["department_id", "person_id", "role_id"], 
    unique: true, 
    :name => 'index_department_person_roles_department_id_person_id_role_id'
  end
end
