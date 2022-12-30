module Api
  module V1
    class GroupsController < Api::V1::ApiController

      api :GET, "Groups", "Get a list of all available groups"

      example <<-EOS
        
      Status Codes with Response
      200: {
    "reviews": [
        {
            "id": 84,
            "user_id": 1,
            "name": "KFC Yum! Center",
            "address": "1 Arena Plaza",
            "city": "Louisville",
            "state": "KY",
            "country": "United States",
            "place_id": "ChIJ8QWjWLxyaYgR5MYIpV71c0c",
            "longitude": "-85.7542438",
            "latitude": "38.25716789999999",
            "cuisine": "Drama",
            "favorite_dish": null,
            "average_score": 5.0,
            "notes": "<p>Very good</p>",
            "date": "2022-11-15",
            "created_at": "2022-11-17T11:02:57.829Z",
            "updated_at": "2022-11-17T11:03:29.960Z",
            "zip_code": "40202-1363",
            "tags": ",hello,working",
            "price_range": 4,
            "status": null,
            "favourite": null,
            "shareable": true,
            "category_id": 1,
            "to_try": false,
            "discarded_at": null,
            "images": [
                "https://cdn.filestackcontent.com/WCxWynf7QX2NJDhXgjqv",
                "https://cdn.filestackcontent.com/2KIs4ADS4OrYQFOgUfQb"
            ],
            "parent_id": null,
            "slug": "U9GSBhCiaArmMmrsgAFqFUedzBhQU51p84",
            "start_date": null,
            "end_date": null,
            "author": null,
            "platform": null,
            "url": null,
            "google_url": null,
            "foursquare_url": "https://foursquare.com/v/antidote/4cab506a2f08236a745c8561",
            "yelp_url": null
        }
        ],
        "meta": {
            "current_page": 1,
            "total_pages": 1
        }
    }
      EOS

      def index
        groups = current_user.groups.all
        pagy, groups = pagy_countless(groups)
        render json: groups, meta: pagy_meta(pagy), each_serializer: GroupSerializer, adapter: :json
      end

      api :POST, "Group", "Create a new group"
      def create
        group = current_user.groups.new(group_params)
        if group.save
          group.review_ids = params[:reviews] if params[:reviews].present?
          render_message("Group Created successfully")
        else
          render_error(500, "Group didn't created successfully")
        end
      end

      api :PUT, "group", "Update a group"
      def update
        group = current_user.groups.find(params[:id])
        group.review_ids = params[:reviews] if params[:reviews].present?
        debugger
        if group.update(group_params)
          render_message("Group updated successfully!")
        else
          render_error(500, "Group didn't updated")
        end
      end

      api :DELETE, "Group", "Update a group"
      def destroy
        group = current_user.groups.find(params[:id])
        if group.discard
          render_message("Group deleted successfully!")
        else
          render_error(500, "Group cannot be deleted")
        end
      end

      private

      def group_params
        params.require(:group).permit(:name)
      end

    end
  end
end