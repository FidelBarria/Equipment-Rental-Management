class Equipment < ApplicationRecord
  belongs_to :category

  def calculate_quantity_in_equipment!(quantity_to_remove)
    update!(quantity: quantity - quantity_to_remove)
  end
end
