class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :event
  belongs_to :user
  has_many :rental_items
  has_many :payments
  has_many :equipment, through: :rental_items

  enum :status, { pending: 0, active: 1, completed: 2, cancelled: 3 }, default: :pending

  after_update :update_equipment_status

  scope :by_status, ->(status) { where(status: status) }

  def calculate_total_value!
    update!(total_value: rental_items.sum(:subtotal))
  end

  def update_equipment_status
    case status
    when "pending"
      equipment.update(status: :pending)

    when "active"
      equipment.update(status: :unavailable)

    when "completed", "cancelled"
      equipment.update(status: :available)
    end
  end
end
