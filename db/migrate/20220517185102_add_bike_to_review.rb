class AddBikeToReview < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :bike, null: false, foreign_key: true
  end
end
