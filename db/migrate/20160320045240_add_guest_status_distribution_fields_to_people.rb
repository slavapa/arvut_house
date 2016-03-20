class AddGuestStatusDistributionFieldsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :guest_status, :string
  end
end
