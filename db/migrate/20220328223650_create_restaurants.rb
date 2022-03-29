class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :city, null: false
      t.string :cuisine
      t.string :favorite_dish
      t.string :country
      t.timestamps
    end
  end
end
