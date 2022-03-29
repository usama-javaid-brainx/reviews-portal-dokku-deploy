class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.float :score, null: false
      t.datetime :visit_time
      t.text :description

      t.timestamps
    end
  end
end
