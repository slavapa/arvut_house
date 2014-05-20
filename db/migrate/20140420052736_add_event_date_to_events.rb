class AddEventDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_date, :date
    remove_index :events, column: :name
    add_index :events, [:name, :event_date], unique: true
  end
end
