class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :event
  belongs_to :user
  has_many :rental_items
  has_many :payments

  enum :status, { pending: 0, active: 1, completed: 2, cancelled: 3 }, default: :pending

  def calculate_total_value!
    update!(total_value: rental_items.sum(:subtotal))
  end
end
