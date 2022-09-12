class RenameRestaurantTableToReview < ActiveRecord::Migration[7.0]
  def up
    remove_reference :meals, :restaurant, index: true, foreign_key: true
    rename_table :restaurants, :reviews
    add_reference :meals, :review, foreign_key: true, index: true
  end

  def down
    remove_reference :meals, :review, foreign_key: true, index: true
    rename_table :reviews, :restaurants
    add_reference :meals, :restaurant, index: true, foreign_key: true
  end
end
