#rails generate migration add_status_to_people status:references
class AddStatusToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :status, index: true
  end
end
