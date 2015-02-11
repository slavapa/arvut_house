class AddForeignkeyToPersonPayments < ActiveRecord::Migration
  
  def up
    execute <<-SQL
      ALTER TABLE person_payments
      ADD CONSTRAINT fk_person_payments_payments
      FOREIGN KEY (payment_id)
      REFERENCES payments(id) 
      ON DELETE CASCADE
    SQL
    
    execute <<-SQL
      ALTER TABLE person_payments
      ADD CONSTRAINT fk_person_payments_people
      FOREIGN KEY (person_id)
      REFERENCES people(id) 
      ON DELETE CASCADE
    SQL
  end
  
  def down
    execute <<-SQL
      ALTER TABLE person_payments
      DROP CONSTRAINT fk_person_payments_payments
    SQL
    
    execute <<-SQL
      ALTER TABLE person_payments
      DROP CONSTRAINT fk_person_payments_people
    SQL
    
  end
  
end
