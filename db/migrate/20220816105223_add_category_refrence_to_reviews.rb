class AddCategoryRefrenceToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :category, index: true
  end
end
