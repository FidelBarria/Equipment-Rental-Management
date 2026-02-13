class CreateEquipment < ActiveRecord::Migration[8.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :category
      t.integer :quantity
      t.decimal :daily_value
      t.string :statu

      t.timestamps
    end
  end
end
