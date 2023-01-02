module Api
  module V1
    class CategoriesController < Api::V1::ApiController
      api :GET, "categories", "Get a list of all available categories"

      example <<-EOS
        
      Status Codes with Response
      200: {
            "categories": [
              {
                  "id": 1,
                  "name": "Restaurants",
                  "address": true,
                  "google_places": true,
                  "price": true,
                  "cuisine": true,
                  "created_at": "2022-12-20T21:04:12.260Z",
                  "updated_at": "2022-12-20T21:04:12.260Z",
                  "active": true,
                  "position": null,
                  "sub_category_title": null,
                  "start_date": null,
                  "end_date": null,
                  "author": null,
                  "platform": null,
                  "url": null,
                  "google_url": null,
                  "foursquare_url": null,
                  "yelp_url": null,
                  "default_category": false,
                  "icon_path": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--3745d7a2c3a1ea12155d58dc364affea8affc9b3/cutlery.svg"
              }
          ]
      }
      EOS

      def index
        categories = Category.all.order(id: :asc)
        render json: categories.map{ |category|
          if category.icon.attached?
            category.as_json.merge(icon_path: url_for(category.icon), sub_category: category.sub_categories)
          else
            category.as_json
          end
        }, adapter: :json
      end

    end
  end
end
