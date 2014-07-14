#rails generate migration add_area_to_people area:string
class AddAreaToPeople < ActiveRecord::Migration
  def change
    add_column :people, :area, :string, limit: 60
  end
end
