#rails generate scaffold Language name:string:index code:string:index 
class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name, limit: 60, null: false
      t.string :code, limit: 2, null: false

      t.timestamps
    end
    
    add_index :languages, :name, unique: true
    add_index :languages, :code, unique: true
  end
end
