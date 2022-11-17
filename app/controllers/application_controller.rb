class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_categories
  include Pagy::Backend

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])
  end

  def after_sign_in_path_for(resource)
    if current_user.second_view?
      homepage_path
    else
      root_path
    end
  end

  def review_filter(reviews)
    debugger
    reviews = reviews.where('state ilike any (array[?])', params[:search].split(' ')).or(reviews.where('state ilike any (array[?])', params[:search])).or(reviews.where('city ilike any (array[?])', params[:search].split(' '))).or(reviews.where('city ilike any (array[?])', params[:search])).or(reviews.where('country ilike any (array[?])', params[:search])).or(reviews.where('name ilike ?', "%#{params[:search]}%").or(reviews.where("cuisine ilike any (array[?])", params[:search])).or(reviews.where("tags ilike '%#{params[:search]}%'")).or(reviews.where("notes ilike '%#{params[:search]}%'"))) if params[:search].present?
    reviews = params[:category_id] == 'all' ? reviews : reviews.where(category_id: params[:category_id]) if params[:category_id].present?
    @cuisines = reviews.pluck(:cuisine).compact.collect { |e| e.strip.downcase }.uniq.sort
    @tags = reviews.pluck(:tags).map { |tags| tags.split(",") }.flatten.collect { |e| e.strip.downcase }.uniq.reject(&:empty?).sort

    if params[:to_try] != 'favourite'
      reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try]) if params[:to_try].present?
    else
      reviews = reviews.where(favourite: true) if params[:to_try].present?
    end

    location = params[:location_filter].split(',').map { |str| str.split(' . ') }.flatten if params[:location_filter].present?
    reviews = reviews.where('state ilike any (array[?])', location).or(reviews.where('city ilike any (array[?])', location)) if params[:location_filter].present?
    reviews = reviews.where('cuisine ilike any (array[?])', params[:cuisines_filter].split(',')) if params[:cuisines_filter].present?
    reviews = reviews.where('tags ilike any (array[?])', params[:tags_filter].split(',').map { |str| "%,#{str}%" }) if params[:tags_filter].present?
    # debugger
    reviews = reviews.order(params[:score] == "recent" ? "created_at desc" : "average_score #{params[:score]} NULLS LAST") if params[:score].present?
              # else
              #   reviews.order("created_at desc")
              #
              #   # Review.default_order(reviews)
              # end

    reviews
  end

  def set_categories
    @categories = Category.where(active: true)
  end
end
