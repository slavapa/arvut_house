#rails generate scaffold Status name:string:index
class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name, limit: 60, null: false

      t.timestamps
    end
    add_index :statuses, :name
  end
end
