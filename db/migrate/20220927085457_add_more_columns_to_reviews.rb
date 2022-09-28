class AddMoreColumnsToReviews < ActiveRecord::Migration[7.0]
  def up
    add_column :reviews, :start_date, :date
    add_column :reviews, :end_date, :date
    add_column :reviews, :author, :text
    add_column :reviews, :platform, :text
    add_column :reviews, :url, :string
    add_column :reviews, :google_url, :string
    add_column :reviews, :foursquare_url, :string
    add_column :reviews, :yelp_url, :string
  end

  def down
    remove_column :reviews, :yelp_url, :string
    remove_column :reviews, :foursquare_url, :string
    remove_column :reviews, :google_url, :string
    remove_column :reviews, :url, :string
    remove_column :reviews, :platform, :text
    remove_column :reviews, :author, :text
    remove_column :reviews, :end_date, :date
    remove_column :reviews, :start_date, :date
  end
end
