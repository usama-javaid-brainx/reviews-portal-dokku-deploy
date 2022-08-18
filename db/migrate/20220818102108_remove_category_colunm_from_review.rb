class RemoveCategoryColunmFromReview < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :category
  end
end
