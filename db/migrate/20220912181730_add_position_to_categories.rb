class AddPositionToCategories < ActiveRecord::Migration[7.0]
  def up
    add_column :categories, :position, :integer
  end
  def down
    remove_column :categories, :position, :integer
  end
end
