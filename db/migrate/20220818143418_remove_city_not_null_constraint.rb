class RemoveCityNotNullConstraint < ActiveRecord::Migration[7.0]
  def up
    change_column :reviews, :city, :string, null: true
  end

  def down
    change_column :reviews, :city, :string, null: false
  end
end
