class Api::V1::ReviewsController < ApiController
  skip_before_action :authenticate_user!, :verify_authenticity_token, only: [:create]
  before_action :validate_key, only: [:create]

  def index
    reviews = Review.all
  end
  def create
    user = User.find_by(phone_number: params[:phone_number])
    rev_name = FetchTitleService.new(params[:review]['url'])
    if params[:phone_number].present? && user.present?
      review = user.reviews.new(name: rev_name.call, category_id: Category.find_by(name: "Others").id, to_try: true, url: params[:url])
      review.save ? message("#{request.env['rack.url_scheme']}://#{request.host_with_port}/reviews/#{review.slug}/edit") : review.errors.full_messages.first
    else
      message("check content type or user dose not exit with this phone number")
    end
  end

  def validate_key
    message("invalid secret key") unless Rails.application.credentials.config[:x_api_key] == request.headers["x-api-key"]
  end

  private

  def message(msg)
    render json: {
      message: msg
    }
  end
end
