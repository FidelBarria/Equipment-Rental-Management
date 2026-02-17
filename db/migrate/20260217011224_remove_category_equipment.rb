class RemoveCategoryEquipment < ActiveRecord::Migration[8.1]
  def change
    remove_column :equipment, :category, :string
  end
end
