class ChangeDefaultofReviewsAttributes < ActiveRecord::Migration[7.0]

  def up
    columns = [:address, :city, :state, :country, :place_id, :longitude, :latitude, :url, :favorite_dish, :foursquare_url, :google_url, :yelp_url, :author, :platform, :notes]
    default_value = ""
    columns.each do |column|
      change_column_default :reviews, column, default_value
      Review.where(column => nil).update_all(column => default_value)
    end
  end

  def down
    columns = [:address, :city, :state, :country, :place_id, :longitude, :latitude, :url, :favorite_dish, :foursquare_url, :google_url, :yelp_url, :author, :platform, :notes]
    default_value = nil
    columns.each do |column|
      change_column_default :reviews, column, default_value
      Review.where(column => "").update_all(column => default_value)
    end
  end

end
