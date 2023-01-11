module Api
  module V1
    class SubCategoriesController < Api::V1::ApiController
      api :GET, "categories/:category_id/sub_categories", "Get a list of all available subcategories against category_id"

      example <<-EOS
        
      Status Codes with Response
      200: {
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

      EOS

      def index
        sub_categories = SubCategory.where(category_id: params[:category_id]).order(id: :asc)
        render json: sub_categories, adapter: :json
      end

    end
  end
end
