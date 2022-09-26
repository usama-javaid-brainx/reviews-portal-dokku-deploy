class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|

      t.string :name, null: false
      t.string :email , null: false
      t.text :description , null: false
      t.string :category_name, null: false

      t.timestamps
    end
  end
end
