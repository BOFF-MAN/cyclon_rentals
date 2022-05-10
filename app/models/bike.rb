class Bike < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :daily_rate, presence: true
  validates :address, presence: true
  validates :description, presence: true
end
