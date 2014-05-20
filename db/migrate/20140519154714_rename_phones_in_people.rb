class RenamePhonesInPeople < ActiveRecord::Migration
  def change
    rename_column :people, :phone, :phone_mob
    rename_column :people, :phone_2, :phone_additional
  end
end
