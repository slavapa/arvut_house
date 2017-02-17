class CreatePaymentTypeStatuses < ActiveRecord::Migration
  def change
    create_table :payment_type_statuses do |t|
      t.references :payment_type, index: true
      t.references :status, index: true

      t.timestamps
    end
  end
end
