class GroupsController < ApplicationController
  def index
    @groups = current_user.groups.all
  end

  def show
    @group = current_user.groups.find(params[:id])
    reviews = current_user.groups.find(params[:id]).reviews
    @pagy, @reviews = pagy_countless(reviews)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def edit_new
    if params[:id].present? #case of edit
      @group = current_user.groups.find(params[:id])
      @selected_reviews = @group.reviews
      @reviews = current_user.reviews.all_except(@selected_reviews)
    else
      #case of new
      @reviews = current_user.reviews
      @group = current_user.groups.new
    end
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      @group.review_ids = params[:group][:reviews] if params[:group][:reviews].present?
      flash[:notice] = "Group created successfully!"
    else
      flash[:alert] = "Error in creating group!"
    end
    redirect_to groups_path
  end

  def update
    @group = current_user.groups.find(params[:id])
    @group.review_ids = params[:group][:reviews] if params[:group][:reviews].present?
    if @group.update(group_params)
      flash[:notice] = "Group updated successfully!"
    else
      flash[:alert] = "Error in updating group!"
    end
    redirect_to groups_path
  end

  def search
    @reviews = current_user.reviews.where('name ilike ?', "%#{params[:search]}%")
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    if @group.discard
      flash[:notice] = "Group deleted successfully!"
    else
      flash[:alert] = "Group cannot be deleted"
    end
    redirect_to groups_path, status: :see_other
  end

  def group_params
    params.require(:group).permit(:name)
  end

end