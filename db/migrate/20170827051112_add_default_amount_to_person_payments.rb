class AddDefaultAmountToPersonPayments < ActiveRecord::Migration
  def change
    add_column :person_payments, :default_amount, :decimal
     
    reversible do |dir|
      dir.up do
        
        PersonPayment.connection.execute("UPDATE person_payments 
          SET default_amount = (SELECT amount FROM payment_types 
          WHERE person_payments.payment_id = payment_types.id)")
      end
      
      dir.down do
      end
    end
  end
end
