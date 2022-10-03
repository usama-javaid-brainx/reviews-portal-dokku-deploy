class AddMoreColumnsToCategories < ActiveRecord::Migration[7.0]
  def up
    add_column :categories, :start_date, :boolean
    add_column :categories, :end_date, :boolean
    add_column :categories, :author, :boolean
    add_column :categories, :platform, :boolean
    add_column :categories, :url, :boolean
    add_column :categories, :google_url, :boolean
    add_column :categories, :foursquare_url, :boolean
    add_column :categories, :yelp_url, :boolean
  end

  def down
    remove_column :categories, :yelp_url, :boolean
    remove_column :categories, :foursquare_url, :boolean
    remove_column :categories, :google_url, :boolean
    remove_column :categories, :url, :boolean
    remove_column :categories, :platform, :boolean
    remove_column :categories, :author, :boolean
    remove_column :categories, :end_date, :boolean
    remove_column :categories, :start_date, :boolean
  end
end
