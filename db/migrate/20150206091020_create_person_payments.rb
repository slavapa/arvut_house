#rails generate model PersonPayment person:references payment:references amount:decimal
class CreatePersonPayments < ActiveRecord::Migration
  def change
    create_table :person_payments do |t|
      t.references :person, index: true, null: false
      t.references :payment, index: true, null: false
      t.decimal :amount

      t.timestamps
    end
    
    add_index :person_payments, ["person_id", "payment_id"], unique: true
  end
end
