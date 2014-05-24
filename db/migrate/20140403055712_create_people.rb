class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string  :name, limit: 60, null: false
      t.string  :family_name, limit: 60
      t.string  :email, limit: 60
      t.string  :phone_mob, limit: 60
      t.integer :gender
      t.string  :id_card_number, limit: 9
      t.string  :address
      t.boolean :admin, default: false
      t.string  :password_digest
      t.string  :remember_token
      t.date    :birth_date
      t.string  :workplace
      t.string  :skills
      t.string  :phone_additional, limit: 60
      t.integer :computer_knowledge
      t.integer :family_status
      t.integer :car_owner

      t.timestamps
    end
    
    add_index :people, :name
    add_index :people, :family_name
    add_index :people, :email, unique: true
    add_index :people, :remember_token
    add_index :people, :id_card_number, unique: true
  end
end
