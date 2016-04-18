class RemoveGuestStatusFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :guest_status, :string
  end
end
