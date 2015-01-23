#rails generate scaffold PaymentType name:string:index frequency:integer:index amount:decimal
class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :name
      t.integer :frequency
      t.decimal :amount

      t.timestamps
    end
    add_index :payment_types, :name, unique: true
    add_index :payment_types, :frequency
  end
end
