class RemoveCategoryColunmFromReview < ActiveRecord::Migration[7.0]
  def up
    remove_column :reviews, :category
  end

  def down
    add_column :reviews, :category, :string
  end
end
