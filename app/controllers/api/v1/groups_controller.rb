module Api
  module V1
    class GroupsController < Api::V1::ApiController

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
      EOS

      def index
        groups = current_user.groups.all
        pagy, groups = pagy_countless(groups)
        render json: groups, meta: pagy_meta(pagy), each_serializer: GroupSerializer, adapter: :json
      end

      api :POST, "groups", "Create a new group"
      def create
        group = current_user.groups.new(group_params)
        if group.save
          group.review_ids = params[:reviews] if params[:reviews].present?
          render_message("Group Created successfully")
        else
          render_error(500, "Group didn't created successfully")
        end
      end

      api :PUT, "groups", "Update a group"
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

      api :DELETE, "groups", "Delete a group"
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