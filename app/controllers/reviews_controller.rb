class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_review, only: [:edit, :destroy, :update]
  before_action :home_data, only: [:homepage, :index]
  before_action :category_order, only: [:homepage, :new, :create, :edit]

  def homepage
    if params[:category_id].present?
      @curr_category = params[:category_id] == "all" ? "all" : Category.find_by(id: params[:category_id])
    else
      @curr_category = "all"
    end
  end

  def index
    duplicate_review if session[:edit_review].present?
  end

  def home_data
    reviews = review_filter(current_user.reviews)
    @pagy, @reviews = pagy(reviews, items: 12)
    @addresses = locations(@reviews)
    @cuisine_presence = (Category.find_by(id: params[:category_id]).name == 'Restaurants' if params[:category_id] != 'all' && params[:category_id].present?) || params[:category_id] == 'all' || params[:category_id].blank?
  end

  def new
    @review = current_user.reviews.new
    @curr_category = params[:category_id].present? ? Category.find_by(id: params[:category_id]) : Category.find_by(name: 'Restaurants')
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      FetchUrlJob.perform_later(@review, params[:review][:city], params[:review][:name]) if params[:review][:city].present? && params[:review][:name].present?
      redirect_to current_user.second_view? ? homepage_path : reviews_path, notice: "Review created successfully!"
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
    if new_review.update(user_id: current_user.id, parent_id: existing_review.id, slug: "#{SecureRandom.base58(32)}#{Review.last.id + 1}", to_try: edit_review == 'true' ? new_review.to_try : true)
      redirect_to edit_review == 'true' ? edit_review_path(new_review) : review_path(new_review.slug)
    else
      redirect_to reviews_path, notice: "Review didn't created successfully please try again"
    end
  end

  def show
    if current_user.blank? || current_user.reviews.find_by(slug: params[:id]).blank?
      redirect_to guest_path
      return
    end

    @review = current_user.reviews.find_by(slug: params[:id])
    @parent_id = @review.parent_id
    @review_user = User.find_by(id: @review.user_id)
  end

  def edit
    @curr_category = @review.category
  end

  def update
    if @review.update(review_params)
      if params[:review][:deleted_meals].blank? || params[:review][:deleted_meals].present? && Meal.where(id: params[:review][:deleted_meals].split(',')).destroy_all
        redirect_to review_path(@review), notice: "Review updated successfully!"
      else
        redirect_to edit_review_path(@review), notice: "Meal did not deleted try again"
      end
    else
      render :new
    end
  end

  def destroy
    if @review.discard
      redirect_to current_user.second_view? ? homepage_path : reviews_path, status: :see_other, notice: "Review deleted successfully!"
    end
  end

  def delete_attachment
    @image = ActiveStorage::Attachment.find(params[:attachment_id])
    @image.purge if @image.present?
  end

  def update_favourite
    Review.find_by(id: params[:review_id]).update(favourite: params[:favourite])
  end

  def update_status
    Review.find_by(slug: params[:review_id]).update(shareable: params[:share])
  end

  def category_order
    @ordered_categories = Category.all.order("position asc")
  end

  def get_score
    geolocations = Array.[]('foursquare', 'yelp')
    foursquare_yelp = FetchRatingsService.new(geolocations, params[:foursquare_yelp_url])
    foursquare_yelp = foursquare_yelp.call
    render json: foursquare_yelp
  end
  private

  def set_review
    @review = current_user.reviews.find_by(slug: params[:id])
  end

  def review_params
    params[:review][:images] = [] if params[:review][:images] == [""]
    params.require(:review).permit(:name, :category_id, :to_try, :shareable, :date, :tags, :address, :state, :city, :country, :zip_code, :latitude, :longitude, :place_id, :favorite_dish, :price_range, :cuisine, :average_score, :start_date, :end_date, :author, :platform, :url, :google_url, :foursquare_url, :yelp_url, :notes, images: [], meals_attributes: [:id, :name, :notes, :image_url, :_destroy])
  end

  def locations(reviews)
    reviews.map do |review|
      if review.city.present? && review.state.present?
        "#{review.city} . #{review.state}"
      elsif review.state.present?
        review.state
      elsif review.city.present?
        review.city
      else
        ''
      end
    end.uniq.reject(&:empty?).sort
  end
end
