class RentalItem < ApplicationRecord
  belongs_to :rental
  belongs_to :equipment

  after_save :update_rental_total_value
  after_destroy :update_rental_total_value

  private

  def update_rental_total_value
    rental.calculate_total_value!
  end
end
