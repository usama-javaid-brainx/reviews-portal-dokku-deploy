class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :show, :update, :destroy]

  def index
    @pagy, @reviews = pagy(current_user.reviews, items: 12)
  end

  def new
    @review = current_user.reviews.new
    @category = Category.all
    @curr_category = Category.find(params[:category])
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
    params.require(:review).permit(:name, :category_id, :shareable, :tags, :address, :state, :city, :country, :zip_code, :latitude, :longitude, :place_id, :favorite_dish, :price_range, :cuisine, :average_score, :notes, images: [], meals_attributes: [:id, :name, :notes, :image_url, :_destroy])
  end
end
