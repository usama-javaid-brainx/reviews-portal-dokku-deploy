class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :show, :update, :destroy]

  def homepage
    if params[:second_view].present?
      switch_homepage
    end
    reviews = review_filter(current_user.reviews)
    @pagy, @reviews = pagy(reviews, items: 12)
    @curr_category = params[:category_id].present? ? Category.find_by(id: params[:category_id]) : Category.find_by(name: 'Restaurants')
    @cuisine_presence = if (Category.find_by(id: params[:category_id]).name == 'Restaurants' if params[:category_id] != 'all' && params[:category_id].present?) || params[:category_id] == 'all' || params[:category_id].blank?
                          true
                        else
                          false
                        end
  end

  def index
    duplicate_review if session[:edit_review].present?
    reviews = review_filter(current_user.reviews)
    @pagy, @reviews = pagy(reviews, items: 12)
    @cuisine_presence = if (Category.find_by(id: params[:category_id]).name == 'Restaurants' if params[:category_id] != 'all' && params[:category_id].present?) || params[:category_id] == 'all' || params[:category_id].blank?
                          true
                        else
                          false
                        end

    if params[:second_view].present?
      switch_homepage
    end
  end

  def switch_homepage
    current_user.update(second_view: params[:second_view])
  end

  def new
    @review = current_user.reviews.new
    @curr_category = params[:category_id].present? ? Category.find_by(id: params[:category_id]) : Category.find_by(name: 'Restaurants')
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to reviews_path, notice: "Review created successfully!"
    else
      @curr_category = params[:review][:category_id].present? ? Category.find_by(id: params[:review][:category_id]) : Category.find_by(name: 'Restaurants')
      render :new
    end
  end

  def duplicate_review
    edit_review = session[:edit_review]
    review_id = session[:review_id]
    session.delete(:review_id)
    session.delete(:edit_review)
    existing_review = Review.find_by(slug: review_id)
    new_review = existing_review.dup
    if new_review.update(user_id: current_user.id, parent_id: existing_review.id, slug: SecureRandom.base58(32), to_try: edit_review == 'true' ? new_review.to_try : true)
      redirect_to edit_review == 'true' ? edit_review_path(new_review) : review_path(new_review)
    else
      redirect_to root_path, notice: "Review didn't created successfully please try again"
    end
  end

  def show
    @parent_id = @review.parent_id
    @review_user = User.find_by(id: @review.user_id)
  end

  def edit
    @curr_category = @review.category
  end

  def update
    if @review.update(review_params)
      redirect_to root_path, notice: "Review updated successfully!"
    else
      render :new
    end
  end

  def destroy
    if @review.discard
      redirect_to root_path, status: :see_other, notice: "Review removed successfully!"
    end
  end

  def delete_attachment
    @image = ActiveStorage::Attachment.find(params[:attachment_id])
    @image.purge if @image.present?
  end

  def update_favourite
    Review.find_by(id: params[:review_id]).update(favourite: params[:favourite])
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params[:review][:images] = [] if params[:review][:images] == [""]
    params.require(:review).permit(:name, :category_id, :to_try, :shareable, :date, :tags, :address, :state, :city, :country, :zip_code, :latitude, :longitude, :place_id, :favorite_dish, :price_range, :cuisine, :average_score, :notes, images: [], meals_attributes: [:id, :name, :notes, :image_url, :_destroy])
  end
end
