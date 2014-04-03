class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string  :name, limit: 60
      t.string  :family_name, limit: 60
      t.string  :email, limit: 60
      t.string  :phone, limit: 60
      t.string  :gender, limit: 1
      t.string  :status, limit: 60
      t.string  :id_card_number, limit: 9
      t.string  :address
      t.boolean :admin, default: false
      t.string  :password_digest
      t.string  :remember_token

      t.timestamps
    end
  add_index :people, :email, unique: true
  add_index  :people, :remember_token
  add_index  :people, :id_card_number
  end
end
