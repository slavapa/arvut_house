class AddDistributionFieldsToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :language, index: true
    add_column :people, :event_description, :string
    add_column :people, :event_date, :date
    add_column :people, :comments, :string
  end
end
