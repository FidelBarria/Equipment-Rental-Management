class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :event
  belongs_to :user
  has_many :rental_items
  has_many :payments
  has_many :equipment, through: :rental_items

  validates :event_id, presence: true, uniqueness: { message: "already has a rental associated" }
  validates :client_id, presence: true
  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validates :total_value, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

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

  def end_date_after_start_date
    if end_date && start_date && end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
