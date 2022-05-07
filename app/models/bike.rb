class Bike < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :daily_rate, presence: true
  validates :address, presence: true
end
