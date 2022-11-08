class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_categories
  include Pagy::Backend

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :password, :avatar])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def review_filter(reviews)
    reviews = reviews.where('name ilike ?', "%#{params[:search]}%") if params[:search].present?
    reviews = params[:category_id] == 'all' ? reviews : reviews.where(category_id: params[:category_id]) if params[:category_id].present?
    @cuisines = reviews.pluck(:cuisine).compact.collect { |e| e.strip.downcase }.uniq.sort
    @tags = reviews.pluck(:tags).map { |tags| tags.split(",") }.flatten.collect { |e| e.strip.downcase }.uniq.reject(&:empty?).sort
    if params[:to_try] != 'favourite'
      reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try]) if params[:to_try].present?
    else
      reviews = reviews.where(favourite: true) if params[:to_try].present?
    end
    reviews = reviews.where('cuisine ilike any (array[?])', params[:cuisines_filter].split(',')) if params[:cuisines_filter].present?
    reviews = reviews.where('tags ilike any (array[?])', params[:tags_filter].split(',').map { |str| "%,#{str}%" }) if params[:tags_filter].present?
    reviews = if params[:score].present?
                reviews.order(params[:score] == "recent" ? "created_at desc" : "average_score #{params[:score]} NULLS LAST")
              else
                reviews.order("created_at desc")
              end
    reviews
  end

  def set_categories
    @categories = Category.where(active: true)
  end
end
