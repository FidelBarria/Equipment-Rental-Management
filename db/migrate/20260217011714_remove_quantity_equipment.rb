class RemoveQuantityEquipment < ActiveRecord::Migration[8.1]
  def change
    remove_column :equipment, :quantity, :integer
  end
end
