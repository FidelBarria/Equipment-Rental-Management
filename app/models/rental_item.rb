class RentalItem < ApplicationRecord
  belongs_to :rental
  belongs_to :equipment

  validate :check_equipment_availability, on: :create

  after_save :update_rental_total_value, :update_quantity_in_equipment
  after_destroy :update_rental_total_value, :restore_equipment_stock

  private

  def restore_equipment_stock
    new_stock = equipment.quantity + self.quantity

    equipment.update!(quantity: new_stock)
  end

  def check_equipment_availability
    # Verificamos se a quantidade pedida é maior do que a que temos em stock
    if quantity > equipment.quantity
      errors.add(:quantity, "is greater than available stock (#{equipment.quantity} left)")
    end
  end

  def update_quantity_in_equipment
    equipment.calculate_quantity_in_equipment!(quantity)
  end

  def update_rental_total_value
    rental.calculate_total_value!
  end
end
