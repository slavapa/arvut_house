class AddDepartmentToPeople < ActiveRecord::Migration
  def change
    add_column :people, :department, :string, limit: 60
  end
end
