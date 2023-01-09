module Api
  module V1
    class GroupsController < Api::V1::ApiController
      before_action :set_group, only: [:update, :destroy ]

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
            "discarded_at": null
          }
        ]
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
          group.review_ids = params[:reviews] if params[:reviews].present?
          render json: group, each_serializer: GroupSerializer, adapter: :json
        else
          render_error(422, "Group didn't created successfully")
        end
      end

      api :PUT, "groups", "Update a group"

      def update
        @group.review_ids = params[:reviews] if params[:reviews].present?
        if @group.update(group_params)
          render json: @group, each_serializer: GroupSerializer, adapter: :json
        else
          render_error(422, "Group didn't updated")
        end
      end

      api :DELETE, "groups", "Delete a group"

      def destroy
        if @group.discard
          render_message("Group deleted successfully!")
        else
          render_error(422, "Group cannot be deleted")
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