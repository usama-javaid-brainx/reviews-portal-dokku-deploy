module Api
  module V1
    class GroupsController < Api::V1::ApiController
      before_action :set_group, only: [:update, :destroy]

      api :GET, "groups", "Get a list of all available groups"

      example <<-EOS
        
      Status Codes with Response
      200: {
        "groups": [
          {
            "id": 31,
            "name": "Test",
            "created_at": "2022-12-06T14:33:23.328Z",
            "updated_at": "2022-12-06T14:33:23.328Z",
            "user_id": 2,
            "discarded_at": null,
            "reviews": [
              {
                "id": 160,
                "user_id": 2,
                "name": "Aschaffenburg",
                "address": "",
                "city": "Aschaffenburg",
                "state": "BY",
                "country": "Germany",
                "place_id": "ChIJFyDtEeRHvUcR4IgWHuTsZJk",
                "longitude": "9.135555400000001",
                "latitude": "49.9806625",
                "favorite_dish": null,
                "average_score": null,
                "notes": "",
                "date": null,
                "created_at": "2022-12-01T14:25:48.648Z",
                "updated_at": "2023-01-12T09:51:21.146Z",
                "zip_code": "",
                "tags": [],
                "price_range": null,
                "status": null,
                "favourite": null,
                "shareable": false,
                "category_id": 1,
                "sub_category_id": null,
                "to_try": false,
                "discarded_at": null,
                "images": [],
                "parent_id": null,
                "slug": "SfaPdyJSvMMbgSygWWBbMHK1UeMzL3si160",
                "start_date": null,
                "end_date": null,
                "author": null,
                "platform": null,
                "url": null,
                "google_url": null,
                "foursquare_url": "https://foursquare.com/v/antidote/4b0e387af964a520155623e3",
                "yelp_url": null
              }
            ],
          }
        ],
        "meta": {
          "current_page": 1,
          "total_pages": 1
        }
      }
      EOS

      def index
        pagy, groups = pagy(current_user.groups)
        render json: groups, meta: pagy_meta(pagy), each_serializer: GroupSerializer, adapter: :json
      end

      api :POST, "groups", "Create a new group"

      def create
        group = current_user.groups.new(group_params)
        if group.save
          group.review_ids = params[:review_ids].uniq if params[:review_ids].present?
          render json: group, each_serializer: GroupSerializer, adapter: :json
        else
          render_error(422, group.errors.full_messages)
        end
      end

      api :PUT, "groups/update", "Update a group"

      def update
        if @group.update(group_params)
          @group.review_ids = params[:review_ids].to_a.uniq
          render json: @group, each_serializer: GroupSerializer, adapter: :json
        else
          render_error(422, @group.errors.full_messages)
        end
      end

      api :DELETE, "groups", "Delete a group"

      def destroy
        if @group.discard
          render_message("Group deleted successfully!")
        else
          render_error(422, @group.errors.full_messages)
        end
      end

      private

      def set_group
        @group = current_user.groups.find(params[:id])
      end

      def group_params
        params.require(:group).permit(:name)
      end

    end
  end
end

