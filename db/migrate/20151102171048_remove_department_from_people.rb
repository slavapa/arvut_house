class RemoveDepartmentFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :department, :string
  end
end
