class AddDefaultInCategories < ActiveRecord::Migration[7.0]
  def up
    add_column :categories, :default_category, :boolean, default: false
  end
  def down
    remove_column :categories, :default_category, :boolean, default: false
  end
end
