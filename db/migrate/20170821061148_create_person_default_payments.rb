class CreatePersonDefaultPayments < ActiveRecord::Migration
  def change
    create_table :person_default_payments do |t|
      t.references :person, index: true, null: false
      t.references :payment_type, index: true, null: false
      t.decimal :amount

      t.timestamps
    end
    
    add_index :person_default_payments, ["person_id", "payment_type_id"], unique: true
  end
end
