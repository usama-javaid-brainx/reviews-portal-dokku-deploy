class GroupsController < ApplicationController
  def index
    groups = current_user.groups.all
    @pagy, @groups = pagy(groups, items: 12)
  end

  def show
    @group = current_user.groups.find(params[:id])
    reviews = current_user.groups.find(params[:id]).reviews
    @pagy, @reviews = pagy(reviews, items: 12)
  end

  def new
    if params[:id].present?
      @group = current_user.groups.find(params[:id])
      @reviews = current_user.reviews
      @selected_reviews = @group.reviews
    else
      @reviews = current_user.reviews
      @group = current_user.groups.new
    end
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      @group.review_ids = params[:group][:reviews] if params[:group][:reviews].present?
      redirect_to groups_path, notice: "Group created successfully!"
    else
      redirect_to groups_path, notice: "Error in creating group!"
    end
  end
  
  def update
    @group = current_user.groups.find(params[:id])
    @group.review_ids = params[:group][:reviews] if params[:group][:reviews].present?
    if @group.update(group_params)
      redirect_to groups_path, notice: "Group updated successfully!"
    else
      redirect_to groups_path, notice: "Error in updating group!"
    end
  end

  def search
    @reviews = current_user.reviews.where('name ilike ?', "%#{params[:search]}%")
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    if @group.discard
      redirect_to groups_path, status: :see_other, notice: "Group deleted successfully!"
    end
  end

  def group_params
    params.require(:group).permit(:name)
  end

end