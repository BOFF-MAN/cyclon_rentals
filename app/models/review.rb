class Review < ApplicationRecord
  belongs_to :user
  belongs_to :bike

  validates :content, presence: true, length: { in: 4..300 }
  validates :rating, presence: true, inclusion: { in: 1..5 }, numericality: { only_integer: true }
end
