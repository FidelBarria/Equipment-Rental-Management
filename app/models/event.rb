class Event < ApplicationRecord
  scope :by_start_and_end_date, ->(start_date, end_date) { where("start_date >= ? AND end_date <= ?", start_date, end_date) }
end
