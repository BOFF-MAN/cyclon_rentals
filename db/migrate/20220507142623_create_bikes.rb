class CreateBikes < ActiveRecord::Migration[6.1]
  def change
    create_table :bikes do |t|
      t.string :name
      t.string :description
      t.float :daily_rate
      t.string :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
