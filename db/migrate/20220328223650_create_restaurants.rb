class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name, null: false
      t.string :city, null: false
      t.string :cuisine
      t.string :favorite_dish
      t.string :country
      t.float :average_score
      t.text :notes
      t.string :google_maps_link
      t.date :date
      t.timestamps
    end
  end
end
