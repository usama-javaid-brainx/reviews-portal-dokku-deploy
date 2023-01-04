class ReviewSerializer < ActiveModel::Serializer

  attributes :user_id, :name, :address, :city, :state, :country, :place_id, :longitude, :latitude, :cuisine, :favorite_dish, :average_score, :notes, :date, :created_at, :updated_at, :zip_code, :tags, :price_range, :status, :favourite, :shareable, :category_id, :to_try, :discarded_at, :images, :parent_id, :slug, :start_date, :end_date, :author, :platform, :url, :google_url, :foursquare_url, :yelp_url
  has_many :meals

  # def attributes(*args)
  #   object.attributes.symbolize_keys
  # end

  def tags
    
  end

end
