class AdicionarCamposAEquipment < ActiveRecord::Migration[8.1]
  def change
    add_column :equipment, :category_id, :integer
  end
end
