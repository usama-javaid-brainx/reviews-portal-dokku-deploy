class AddColumnsToResturants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :zip_code, :string, default: ""
    add_column :restaurants, :tags, :string, default: ""
    add_column :restaurants, :price_range, :integer
    add_column :restaurants, :status, :integer
    add_column :restaurants, :favourite, :boolean
    add_column :restaurants, :shareable, :boolean
  end
end
