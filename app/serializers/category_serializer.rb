class CategorySerializer < ActiveModel::Serializer

  attributes :name, :address, :icon, :google_places, :price, :cuisine, :active, :position, :sub_category_title, :start_date, :end_date, :author, :platform, :url, :google_url, :foursquare_url, :yelp_url, :created_at, :updated_at, :customized_fields
  has_many :sub_categories

  def icon
    Rails.application.routes.url_helpers.rails_blob_url(@object.icon) if @object.icon.attached?
  end

  def customized_fields
    if object.name == "Restaurants"
      [
        "Location": true,
        "Name": true,
        "Cuisines": true,
        "Date": true,
        "Start Date": false,
        "End Date": false,
        "Url": true,
        "Foursquare Url": true,
        "Yelp Url": true,
        "Google Url": false,
        "Author": false,
        "Score": true,
        "Price": true,
        "Description": true,
        "Photos": true,
        "Address": true,
        "City": true,
        "State": true,
        "Zip Code": true,
        "Country": true,
        "Tags": true,
        "Highlights": true
      ]
    elsif object.name == "Video Games"
      [
        "Location": false,
        "Name": true,
        "Genres": true,
        "Date": true,
        "Start Date": false,
        "End Date": false,
        "Url": true,
        "Foursquare Url": true,
        "Yelp Url": false,
        "Google Url": false,
        "Author": false,
        "Score": true,
        "Price": true,
        "Description": true,
        "Photos": true,
        "Address": false,
        "City": false,
        "State": false,
        "Zip Code": false,
        "Country": false,
        "Tags": true,
        "Highlights": false
      ]
    elsif object.name == "Books" || object.name == "Movies"
      [
        "Location": false,
        "Name": true,
        "Genres": true,
        "Date": true,
        "Start Date": false,
        "End Date": false,
        "Url": true,
        "Foursquare Url": false,
        "Yelp Url": false,
        "Google Url": false,
        "Author": false,
        "Score": true,
        "Price": true,
        "Description": true,
        "Photos": true,
        "Address": false,
        "City": false,
        "State": false,
        "Zip Code": false,
        "Country": false,
        "Tags": true,
        "Highlights": false
      ]
    elsif object.name == "TV Shows"
      [
        "Location": false,
        "Name": true,
        "Genres": true,
        "Date": true,
        "Start Date": true,
        "End Date": true,
        "Url": true,
        "Foursquare Url": false,
        "Yelp Url": false,
        "Google Url": true,
        "Author": false,
        "Score": true,
        "Price": true,
        "Description": true,
        "Photos": true,
        "Address": false,
        "City": false,
        "State": false,
        "Zip Code": false,
        "Country": false,
        "Tags": true,
        "Highlights": false
      ]
    elsif object.name == "Accommodations"
      [
        "Location": false,
        "Name": true,
        "Genres": true,
        "Date": true,
        "Start Date": true,
        "End Date": true,
        "Url": true,
        "Foursquare Url": false,
        "Yelp Url": false,
        "Google Url": true,
        "Author": false,
        "Score": true,
        "Price": true,
        "Description": true,
        "Photos": true,
        "Address": true,
        "City": true,
        "State": true,
        "Zip Code": true,
        "Country": true,
        "Tags": true,
        "Highlights": false
      ]
    elsif object.name == "Others"
      [
        "Location": false,
        "Name": true,
        "Genres": false,
        "Date": false,
        "Start Date": false,
        "End Date": false,
        "Url": false,
        "Foursquare Url": false,
        "Yelp Url": false,
        "Google Url": false,
        "Author": false,
        "Score": false,
        "Price": false,
        "Description": true,
        "Photos": true,
        "Address": true,
        "City": true,
        "State": true,
        "Zip Code": true,
        "Country": true,
        "Tags": true,
        "Highlights": false
      ]
    end
  end

end

