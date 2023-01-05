module Api
  module V1
    class CategoriesController < Api::V1::ApiController
      api :GET, "categories", "Get a list of all available categories"

      example <<-EOS
        
      Status Codes with Response
      200: {
            "categories": [
              {
            "name": "Restaurants",
            "address": true,
            "icon": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--3745d7a2c3a1ea12155d58dc364affea8affc9b3/cutlery.svg",
            "google_places": true,
            "price": true,
            "cuisine": true,
            "active": true,
            "position": 1,
            "sub_category_title": "Genres",
            "start_date": null,
            "end_date": null,
            "author": null,
            "platform": null,
            "url": null,
            "google_url": null,
            "foursquare_url": null,
            "yelp_url": null,
            "created_at": "2022-08-23T10:16:26.562Z",
            "updated_at": "2022-12-14T12:43:26.245Z",
            "customized_fields": [
                "Location",
                "Name",
                "Cuisines",
                "Date",
                "Url",
                "Foursquare Url",
                "Yelp Url",
                "Score",
                "Price",
                "Description",
                "Photos",
                "Address",
                "City",
                "State",
                "Zip Code",
                "Country",
                "Tags",
                "Highlights"
            ],
            "sub_categories": [
                {
                    "id": 1,
                    "category_id": 1,
                    "name": "Action",
                    "created_at": "2022-09-28T09:06:18.299Z",
                    "updated_at": "2022-09-28T09:06:18.299Z"
                }
            ]
        }
          ]
      }
      EOS

      def index
        categories = Category.all.order(id: :asc)
        render json: categories, each_serializer: CategorySerializer, adapter: :json
      end

    end
  end
end
