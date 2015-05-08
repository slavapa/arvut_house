class AddCarNumberEmail2ToPeople < ActiveRecord::Migration
  def change
    add_column :people, :car_number, :string, limit: 60
    add_column :people, :email_2, :string, limit: 60
  end
end
