class GroupsController < ApplicationController
  def index
    groups = current_user.groups.all
    @reviews = current_user.reviews
    @pagy, @groups = pagy(groups, items: 12)
  end

  def show
    @group = current_user.groups.find(params[:id])
    reviews = current_user.groups.find(params[:id]).reviews
    @pagy, @reviews = pagy(reviews, items: 12)
  end

  def create
    debugger
  end

  def update
    debugger
  end

  def search
    reviews = current_user.reviews.where('name ilike ?', "%#{params[:search]}%") if params[:search].present?
    render json: [search_reviews: reviews]
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    # if @group.discard
    #   redirect_to groups_path, status: :see_other, notice: "Group deleted successfully!"
    # end
  end

end