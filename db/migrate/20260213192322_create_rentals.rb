class CreateRentals < ActiveRecord::Migration[8.1]
  def change
    create_table :rentals do |t|
      t.integer :client_id
      t.integer :event_id
      t.integer :user_id
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.decimal :total_value

      t.timestamps
    end
  end
end
