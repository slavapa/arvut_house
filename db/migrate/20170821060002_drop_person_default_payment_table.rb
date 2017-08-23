class DropPersonDefaultPaymentTable < ActiveRecord::Migration
  def change
    drop_table(:person_default_payments, if_exists: true)
     
    if index_exists?(:person_default_payments, ["person_id", "payment_type_id"])
      remove_index :person_default_payments, ["person_id", "payment_type_id"]
    end
  end
end
