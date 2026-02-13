class Client < ApplicationRecord
  has_many :events
  has_many :rentals
end
