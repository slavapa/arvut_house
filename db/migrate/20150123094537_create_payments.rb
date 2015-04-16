#rails generate scaffold Payment description:string:index payment_date:date payment_type:references
class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :description
      t.date :payment_date
      t.references :payment_type, index: true

      t.timestamps
    end
    add_index :payments, :description
  end
end
