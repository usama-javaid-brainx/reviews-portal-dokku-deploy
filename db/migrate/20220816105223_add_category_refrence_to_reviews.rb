class AddCategoryRefrenceToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :categories, index: true
  end
end
