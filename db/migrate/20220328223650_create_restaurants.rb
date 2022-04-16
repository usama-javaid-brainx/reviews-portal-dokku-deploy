class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name, null: false
      t.string :address
      t.string :city, null: false
      t.string :state
      t.string :country
      t.string :place_id
      t.string :longitude
      t.string :latitude
      t.string :cuisine
      t.string :favorite_dish
      t.float :average_score
      t.text :notes
      t.date :date
      t.timestamps
    end
  end
end
