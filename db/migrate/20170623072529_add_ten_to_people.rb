class AddTenToPeople < ActiveRecord::Migration
  def change
    add_column :people, :ten, :integer
  end
end
