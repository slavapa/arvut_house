#rails generate migration payment_type_foreignkey_to_payments

class PaymentTypeForeignkeyToPayments < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE payments
      ADD CONSTRAINT fk_payments_payment_types
      FOREIGN KEY (payment_type_id)
      REFERENCES payment_types(id) 
      ON DELETE RESTRICT
    SQL
    
  end
  
  def down
    execute <<-SQL
      ALTER TABLE payments
      DROP CONSTRAINT fk_payments_payment_types
    SQL
    
  end
end
