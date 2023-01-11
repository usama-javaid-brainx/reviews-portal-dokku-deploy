class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_categories
  include Pagy::Backend

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number])
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def review_filter(reviews)
    # or(reviews.where("cuisine ilike any (array[?])", params[:search]))
    reviews = reviews.where('state ilike any (array[?])', params[:search].split(' ')).or(reviews.where('state ilike any (array[?])', params[:search])).or(reviews.where('city ilike any (array[?])', params[:search].split(' '))).or(reviews.where('city ilike any (array[?])', params[:search])).or(reviews.where('country ilike any (array[?])', params[:search])).or(reviews.where('name ilike ?', "%#{params[:search]}%").or(reviews.where("tags ilike '%#{params[:search]}%'")).or(reviews.where("notes ilike '%#{params[:search]}%'"))) if params[:search].present?
    reviews = params[:category_id] == 'all' ? reviews : reviews.where(category_id: params[:category_id]) if params[:category_id].present?
    @cuisines = Subcategory.where(id: reviews.pluck(:sub_category_id).uniq).pluck(:name).sort
    @tags = reviews.pluck(:tags).map { |tags| tags.split(",") }.flatten.collect { |e| e.strip.downcase }.uniq.reject(&:empty?).sort

    if params[:to_try] != 'favourite'
      reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try]) if params[:to_try].present?
    else
      reviews = reviews.where(favourite: true) if params[:to_try].present?
    end

    location = params[:location_filter].split(',').map { |str| str.split(' . ') }.flatten if params[:location_filter].present?
    reviews = reviews.where('state ilike any (array[?])', location).or(reviews.where('city ilike any (array[?])', location)) if params[:location_filter].present?
    # reviews = reviews.where('cuisine ilike any (array[?])', params[:cuisines_filter].split(',')) if params[:cuisines_filter].present?
    reviews = reviews.where('tags ilike any (array[?])', params[:tags_filter].split(',').map { |str| "%,#{str}%" }) if params[:tags_filter].present?
    reviews = if params[:score].present?
                reviews.order(params[:score] == "recent" ? "created_at desc" : "average_score #{params[:score]} NULLS LAST")
              else
                reviews.order(Arel.sql("CASE WHEN date IS NOT NULL THEN date WHEN start_date IS NOT NULL THEN start_date ELSE created_at END"))
              end

    reviews
  end

  def set_categories
    @all_categories = Category.where(active: true).order(id: :asc)
    @default_categories = Category.where(default_category: true).order(id: :asc)
    @common_categories = Category.where(default_category: false).order(id: :asc)
  end

end
