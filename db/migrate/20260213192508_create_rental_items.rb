class CreateRentalItems < ActiveRecord::Migration[8.1]
  def change
    create_table :rental_items do |t|
      t.integer :rental_id
      t.integer :equipment_id
      t.integer :quantity
      t.decimal :daily_price
      t.decimal :subtotal

      t.timestamps
    end
  end
end
