class ChangeStringInEquipment < ActiveRecord::Migration[8.1]
  def change
    change_column :equipment, :status, :integer
  end
end
