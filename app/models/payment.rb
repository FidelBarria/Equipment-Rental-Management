class Payment < ApplicationRecord
  belongs_to :rental

  enum :payment_method, { credit_card: 0, debit_card: 1, cash: 2, bank_transfer: 3, pix: 4 }, default: :credit_card
  enum :status, { pending: 0, completed: 1, failed: 2 }, default: :pending

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_date, presence: true
  validates :payment_method, presence: true
  validates :status, presence: true
end
