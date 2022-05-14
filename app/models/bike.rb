class Bike < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :daily_rate, presence: true
  validates :address, presence: true
  validates :description, presence: true
end
