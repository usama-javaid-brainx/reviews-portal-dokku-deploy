class RemoveCityNotNullConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :city, :string, :null => true
  end
end
