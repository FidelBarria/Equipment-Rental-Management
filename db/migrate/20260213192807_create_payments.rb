class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.integer :rental_id
      t.decimal :amount
      t.date :payment_date
      t.integer :payment_method
      t.integer :status

      t.timestamps
    end
  end
end
