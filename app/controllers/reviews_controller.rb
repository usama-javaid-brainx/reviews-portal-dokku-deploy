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
      redirect_to root_path, notice: "Review updated successfully!"
    else
      render :new
    end
  end

  def destroy
    # TODO
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
    params.require(:review).permit(:name, :category_id, :to_try, :shareable, :date, :tags, :address, :state, :city, :country, :zip_code, :latitude, :longitude, :place_id, :favorite_dish, :price_range, :cuisine, :average_score, :notes, images: [], meals_attributes: [:id, :name, :notes, :image_url, :_destroy])
  end

  def review_filter(reviews)
    reviews = reviews.where('name ilike ?', "%#{params[:search]}%") if params[:search].present?
    reviews = params[:category] == 'all' ? reviews : reviews.where(category_id: Category.find_by(name: params[:category])) if params[:category].present?
    @cuisines = reviews.select(:cuisine).distinct
    @tags = reviews.pluck(:tags).map { |tags| tags.split(",") }.flatten.uniq.reject(&:empty?)
    if params[:to_try] != 'favourite'
      reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try]) if params[:to_try].present?
    else
      reviews = reviews.where(favourite: true) if params[:to_try].present?
    end
    reviews = reviews.where(cuisine: params[:cuisines_filter].split(',')) if params[:cuisines_filter].present?
    reviews = reviews.where('tags ilike any (array[?])', params[:tags_filter].split(',').map { |str| "%,#{str}%" }) if params[:tags_filter].present?
    reviews = reviews.order(average_score: params[:score]) if params[:score].present?
    reviews
  end
end
