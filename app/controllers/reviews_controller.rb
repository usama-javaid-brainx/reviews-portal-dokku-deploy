class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :show, :update, :destroy]

  def index
    duplicate_review if session[:edit_review].present?
    reviews = review_filter(current_user.reviews.kept)
    @pagy, @reviews = pagy(reviews, items: 12)
    @cuisine_presence = if (Category.find_by(id: params[:category]).name == 'Restaurants' if params[:category] != 'all') || params[:category] == 'all'
                          true
                        else
                          false
                        end
  end

  def new
    @review = current_user.reviews.new
    @curr_category = if params[:category_id].present?
                       Category.find_by(id: params[:category_id])
                     else
                       params[:category] != 'all' ? Category.find_by(name: params[:category]) : Category.find_by(name: 'Restaurants')
                     end
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to reviews_path, notice: "Review created successfully!"
    else
      @curr_category = Category.find_by(id: params[:review][:category_id]) if params[:review][:category_id].present?
      render :new
    end
  end

  def duplicate_review
    edit_review = session[:edit_review]
    review_id = session[:review_id]
    session.delete(:review_id)
    session.delete(:edit_review)
    new_review = Review.find_by(id: review_id).dup
    if new_review.update(user_id: current_user.id, to_try: edit_review == 'true' ? new_review.to_try : true )
      redirect_to edit_review == 'true' ? edit_review_path(new_review) : review_path(new_review)
    else
      redirect_to root_path, notice: "Review didn't created successfully please try again"
    end
  end

  def show

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
    Review.find_by(id: params[:review_id].to_s).update(favourite: params[:favourite].to_s)
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:name, :category_id, :to_try, :shareable, :date, :tags, :address, :state, :city, :country, :zip_code, :latitude, :longitude, :place_id, :favorite_dish, :price_range, :cuisine, :average_score, :notes, images: [], meals_attributes: [:id, :name, :notes, :image_url, :_destroy])
  end
end
