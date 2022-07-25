class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.string :notes
      t.timestamps

      t.references :restaurant, foreign_key: true
    end
  end
end
