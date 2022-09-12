class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :address
      t.boolean :google_places
      t.boolean :price
      t.boolean :cuisine
      t.timestamps
    end
  end
end
