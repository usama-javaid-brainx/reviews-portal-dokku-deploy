class ChangeDefaultofReviewsAttributes < ActiveRecord::Migration[7.0]

  def up
    columns = [:address, :city, :state, :country, :place_id, :longitude, :latitude, :url, :favorite_dish, :foursquare_url, :google_url, :yelp_url, :author, :platform, :notes]
    columns.each do |column|
      change_column_default :reviews, column, ""
      Review.where(column => nil).update_all(column => "")
    end
  end

  def down
    columns = [:address, :city, :state, :country, :place_id, :longitude, :latitude, :url, :favorite_dish, :foursquare_url, :google_url, :yelp_url, :author, :platform, :notes]
    columns.each do |column|
      change_column_default :reviews, column, nil
      Review.where(column => "").update_all(column => nil)
    end
  end

end
