#rails generate scaffold PaymetType name:string:index frequency:integer:index
class CreatePaymetTypes < ActiveRecord::Migration
  def change
    create_table :paymet_types do |t|
      t.string :name, limit: 60, null: false
      t.integer :frequency

      t.timestamps
    end
    add_index :paymet_types, :name
    add_index :paymet_types, :frequency
  end
end
