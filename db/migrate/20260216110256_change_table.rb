class ChangeTable < ActiveRecord::Migration[8.1]
  def change
    rename_column :equipment, :statu, :status
  end
end
