class RenameRestaurantTableToReview < ActiveRecord::Migration[7.0]
  def self.up
    rename_table :restaurants, :reviews
    rename_column :meals, :restaurant_id, :review_id
  end

  def self.down
    rename_table :reviews, :restaurants
    rename_column :meals, :review_id, :restaurant_id
  end
end
