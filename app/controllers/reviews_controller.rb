class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :show, :update, :destroy]

  def index
    reviews = review_filter(current_user.reviews)
    @pagy, @reviews = pagy(reviews, items: 12)
  end

  def new
    @review = current_user.reviews.new
    @curr_category = params[:category_id].present? ? Category.find_by(id: params[:category_id]) : Category.find_by(name: 'Restaurants')
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to reviews_path, notice: "Restaurant created successfully!"
    else
      render :new
    end
  end

  def show

  end

  def edit
    @curr_category = @review.category
    render :new
  end

  def update
    if @review.update(review_params)
      redirect_to reviews_path, notice: "Restaurant updated successfully!"
    else
      render :new
    end
  end

  def destroy
    redirect_to reviews_path, notice: "Restaurant deleted successfully!" if @review.destroy
  end

  def delete_attachment
    @image = ActiveStorage::Attachment.find(params[:attachment_id])
    @image.purge if @image.present?
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:name, :category_id, :to_try, :shareable, :date, :tags, :address, :state, :city, :country, :zip_code, :latitude, :longitude, :place_id, :favorite_dish, :price_range, :cuisine, :average_score, :notes, images: [], meals_attributes: [:id, :name, :notes, :image_url, :_destroy])
  end
  def review_filter(reviews)
    params[:to_try] = 'all' if !params[:to_try].present?
    params[:category] = 'Restaurants' if !params[:category].present?
    reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try] == 'true') if params[:to_try].present?
    reviews = reviews.where(category_id: Category.find_by(name: params[:category])) if params[:category].present?
    @cuisines = reviews.select(:cuisine).distinct
    reviews = reviews.order(average_score: params[:score].to_s) if params[:score].present?
    reviews
  end
end
