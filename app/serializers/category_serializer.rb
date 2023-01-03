class CategorySerializer < ActiveModel::Serializer

  attributes :name, :address, :icon, :google_places, :price, :cuisine, :active, :position, :sub_category_title, :start_date, :end_date, :author, :platform, :url, :google_url, :foursquare_url, :yelp_url, :created_at, :updated_at
  has_many :sub_categories

  def icon
    Rails.application.routes.url_helpers.rails_blob_url(@object.icon) if @object.icon.attached?
  end
end

