class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :event
  belongs_to :user
  has_many :rental_items
  has_many :payments
end
