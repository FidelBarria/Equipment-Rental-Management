class Equipment < ApplicationRecord
  belongs_to :category

  enum :status, { available: 0, rented: 1, unavailable: 2, pending: 3 }, default: :available

  validates :name, presence: true
  validates :daily_value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category_id, presence: true

  scope :by_name, ->(term) { where("name LIKE ?", "%#{term}%") if term.present? }
  scope :available_for_rental, -> { where(status: [ :available, :pending ]) }
end
