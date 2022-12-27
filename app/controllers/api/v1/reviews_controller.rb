module Api
  module V1
    class ReviewsController < Api::V1::ApiController
      skip_before_action :authenticate_user!, only: [:create]
      before_action :validate_key, only: [:create]

      def index
        reviews = Review.all
        if (params[:filters].present? || params[:search].present? || params[:to_try].present? || params[:order].present? || params[:category_id].present?)
          reviews = review_filter(reviews)
        end
        render json: reviews
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

      def review_filter(reviews)
        reviews = reviews.where('state ilike any (array[?])', params[:search].split(' ')).or(reviews.where('state ilike any (array[?])', params[:search])).or(reviews.where('city ilike any (array[?])', params[:search].split(' '))).or(reviews.where('city ilike any (array[?])', params[:search])).or(reviews.where('country ilike any (array[?])', params[:search])).or(reviews.where('name ilike ?', "%#{params[:search]}%").or(reviews.where("cuisine ilike any (array[?])", params[:search])).or(reviews.where("tags ilike '%#{params[:search]}%'")).or(reviews.where("notes ilike '%#{params[:search]}%'"))) if params[:search].present?
        reviews = params[:category_id] == 'all' ? reviews : reviews.where(category_id: params[:category_id]) if params[:category_id].present?
        location = params[:filters][:location].map { |str| str.split(' . ') }.flatten if params[:filters][:location].present?
        reviews = reviews.where('state ilike any (array[?])', location).or(reviews.where('city ilike any (array[?])', location)) if params[:filters][:location].present?
        reviews = reviews.where('cuisine ilike any (array[?])', params[:filters][:cuisine]) if params[:filters][:cuisine].present?
        reviews = reviews.where('tags ilike any (array[?])', params[:filters][:tag].map { |str| "%,#{str}%" }) if params[:filters][:tag].present?
        reviews = reviews.where(to_try: params[:to_try]) if params[:to_try].present?
        reviews = if params[:order].present?
                    reviews.order(params[:order] == "recent" ? "created_at desc" : "average_score #{params[:order]} NULLS LAST")
                  else
                    reviews.order(Arel.sql("CASE WHEN date IS NOT NULL THEN date WHEN start_date IS NOT NULL THEN start_date ELSE created_at END"))
                  end
        reviews
      end

    end
  end
end