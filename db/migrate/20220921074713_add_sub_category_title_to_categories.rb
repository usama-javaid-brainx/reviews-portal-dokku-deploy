class AddSubCategoryTitleToCategories < ActiveRecord::Migration[7.0]
  def up
    add_column :categories, :sub_category_title, :string
  end
  def down
    remove_column :categories, :sub_category_title, :string
  end
end
