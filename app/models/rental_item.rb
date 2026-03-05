class RentalItem < ApplicationRecord
  belongs_to :rental
  belongs_to :equipment

  validate :check_equipment_availability

  after_save :update_rental_total_value, :update_equipment_status
  after_destroy :update_rental_total_value, :update_equipment_status_when_delete


  private

  def check_equipment_availability
    return unless equipment.present?

    unless equipment.available? || equipment.pending?
      errors.add(:base, "is not available for rental")
    end
  end

  def update_rental_total_value
    rental.calculate_total_value!
  end

  def update_equipment_status_when_delete
    equipment.update(status: :available)
  end

  def update_equipment_status
    case rental.status
    when "pending"
      equipment.update(status: :pending)

    when "active"
      equipment.update(status: :rented)

    when "completed", "cancelled"
      equipment.update(status: :available)
    end
  end
end
