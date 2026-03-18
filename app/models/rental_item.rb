class RentalItem < ApplicationRecord
  belongs_to :rental
  belongs_to :equipment

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :daily_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :equipment_must_be_available, on: :create

  before_save :calculate_subtotal
  after_save :update_rental_total_value
  after_destroy :update_rental_total_value

  private

  def equipment_must_be_available
    return unless equipment.present?

    unless equipment.available? || equipment.pending?
      errors.add(:base, "Equipment '#{equipment.name}' is not available for rental")
    end
  end

  def calculate_subtotal
    return unless daily_price && quantity && rental

    days = (rental.end_date - rental.start_date).to_i
    days = 1 if days < 1
    self.subtotal = daily_price * quantity * days
  end

  def update_rental_total_value
    rental.calculate_total_value!
  end
end
