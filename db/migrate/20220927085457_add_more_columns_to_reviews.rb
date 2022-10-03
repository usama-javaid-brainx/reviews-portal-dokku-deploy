class AddMoreColumnsToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :start_date, :date
    add_column :reviews, :end_date, :date
    add_column :reviews, :author, :string
    add_column :reviews, :platform, :string
    add_column :reviews, :url, :string
    add_column :reviews, :google_url, :string
    add_column :reviews, :foursquare_url, :string
    add_column :reviews, :yelp_url, :string
  end
end
