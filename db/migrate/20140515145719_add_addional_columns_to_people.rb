class AddAddionalColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :birth_date, :date
    add_column :people, :workplace, :string
    add_column :people, :skills, :string
    add_column :people, :phone_2, :string, limit: 60
    add_column :people, :computer_knowledge, :integer
    add_column :people, :family_status, :integer
    add_column :people, :car_owner, :integer
  end
end
