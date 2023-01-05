class CategorySerializer < ActiveModel::Serializer

  attributes :name, :address, :icon, :google_places, :price, :cuisine, :active, :position, :sub_category_title, :start_date, :end_date, :author, :platform, :url, :google_url, :foursquare_url, :yelp_url, :created_at, :updated_at, :customized_fields
  has_many :sub_categories

  def icon
    Rails.application.routes.url_helpers.rails_blob_url(@object.icon) if @object.icon.attached?
  end

  def customized_fields
    if object.name == "Restaurants"
      [ "Location", "Name", "Cuisines", "Date", "Url", "Foursquare Url", "Yelp Url", "Score", "Price", "Description", "Photos", "Address", "City", "State", "Zip Code", "Country", "Tags", "Highlights" ]
    elsif object.name == "Video Games"
      [ "Name", "Genres", "Date", "Url", "Foursquare Url", "Score", "Price", "Description", "Photos", "Tags" ]
    elsif object.name == "Books" || object.name == "Movies"
      [ "Name", "Genres", "Date", "Url", "Score", "Price", "Description", "Photos", "Tags" ]
    elsif object.name == "TV Shows"
      [ "Name", "Genres", "Date","Start Date","End Date", "Url", "Google Url", "Score", "Price", "Description", "Photos", "Tags" ]
    elsif object.name == "Accommodations"
      [ "Name", "Genres", "Date","Start Date","End Date", "Url", "Google Url", "Score", "Price", "Description", "Photos", "Address", "City", "State", "Zip Code", "Country", "Tags"  ]
    elsif object.name == "Others"
      [ "Name", "Date", "Url", "Description", "Photos", "Address", "City", "State", "Zip Code", "Country", "Tags"  ]
    end
  end

end

