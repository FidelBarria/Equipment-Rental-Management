class Equipment < ApplicationRecord
  belongs_to :category

  enum :status, { available: 0, rented: 1, unavailable: 2, pending: 3 }, default: :available

  scope :by_name, ->(term) { where("name LIKE ?", "%#{term}%") if term.present? }
end
