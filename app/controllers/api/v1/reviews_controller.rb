module Api
  module V1
    class ReviewsController < Api::V1::ApiController
      skip_before_action :authenticate_user!, only: [:create_review_with_num]
      before_action :validate_key, only: [:create_review_with_num]

      api :GET, "reviews", "Get a list of current user reviews or with applied filters"

      example <<-EOS
        
      Status Codes with Response
      200: {
    "reviews": [
        {
            "id": 84,
            "user_id": 1,
            "name": "KFC Yum! Center",
            "address": "1 Arena Plaza",
            "city": "Louisville",
            "state": "KY",
            "country": "United States",
            "place_id": "ChIJ8QWjWLxyaYgR5MYIpV71c0c",
            "longitude": "-85.7542438",
            "latitude": "38.25716789999999",
            "cuisine": "Drama",
            "favorite_dish": null,
            "average_score": 5.0,
            "notes": "<p>Very good</p>",
            "date": "2022-11-15",
            "created_at": "2022-11-17T11:02:57.829Z",
            "updated_at": "2022-11-17T11:03:29.960Z",
            "zip_code": "40202-1363",
            "tags": ",hello,working",
            "price_range": 4,
            "status": null,
            "favourite": null,
            "shareable": true,
            "category_id": 1,
            "to_try": false,
            "discarded_at": null,
            "images": [
                "https://cdn.filestackcontent.com/WCxWynf7QX2NJDhXgjqv",
                "https://cdn.filestackcontent.com/2KIs4ADS4OrYQFOgUfQb"
            ],
            "parent_id": null,
            "slug": "U9GSBhCiaArmMmrsgAFqFUedzBhQU51p84",
            "start_date": null,
            "end_date": null,
            "author": null,
            "platform": null,
            "url": null,
            "google_url": null,
            "foursquare_url": "https://foursquare.com/v/antidote/4cab506a2f08236a745c8561",
            "yelp_url": null
        }
        ],
        "meta": {
            "current_page": 1,
            "total_pages": 1
        }
    }

      EOS

      def index
        reviews = current_user.reviews
        if (params[:to_try].present?)
          reviews = current_user.reviews.where(to_try: params[:to_try])
        end
        if reviews.present?
          pagy, reviews = pagy_countless(reviews)
          render json: reviews, meta: pagy_meta(pagy), each_serializer: ReviewSerializer, adapter: :json
        else
          render_error(500, "No record found")
        end
      end

      api :GET, "reviews", "Get a list of current user reviews with applied filters"

      example <<-EOS
        
      Status Codes with Response
      200: {
    "reviews": [
        {
            "id": 48,
            "user_id": 2,
            "name": "Ajmer",
            "address": "خَشَاش",
            "city": "Ajmer",
            "state": "RJ",
            "country": "India",
            "place_id": "ChIJAc23_NjmazkR7gCB6xKPr8s",
            "longitude": "74.6399163",
            "latitude": "26.4498954",
            "cuisine": "Arcade game",
            "favorite_dish": null,
            "average_score": 4.99,
            "notes": "<p>Good food</p>",
            "date": "2022-09-21",
            "created_at": "2022-09-22T09:34:38.094Z",
            "updated_at": "2022-12-27T11:46:35.440Z",
            "zip_code": "600037",
            "tags": ",hello,no,good,uyes",
            "price_range": 4,
            "status": null,
            "favourite": true,
            "shareable": false,
            "category_id": 3,
            "to_try": true,
            "discarded_at": null,
            "images": [
                "https://cdn.filestackcontent.com/1i3dk9TeQBizFX6fpyIo",
                "https://cdn.filestackcontent.com/BXwx7WOaTFuotADE0Iss",
                "https://cdn.filestackcontent.com/tFo1NkSSha4ZjW0qHKgM",
                "https://cdn.filestackcontent.com/zxBuOcxLS3OU9WxfA2X7",
                "https://cdn.filestackcontent.com/Fa6pAj3GTyWVBloGgiLS"
            ],
            "parent_id": null,
            "slug": "tq3ohcJfSB2ZT1GeeB9yqQi9nvGxKcg4",
            "start_date": null,
            "end_date": null,
            "author": null,
            "platform": null,
            "url": null,
            "google_url": null,
            "foursquare_url": null,
            "yelp_url": null
        }
    ],
    "meta": {
        "current_page": 1,
        "total_pages": 1
    }
      EOS

      def filtered_reviews
        reviews = review_filter(current_user.reviews)
        pagy, reviews = pagy_countless(reviews)
        render json: reviews, meta: pagy_meta(pagy), each_serializer: ReviewSerializer, adapter: :json
      end

      def create
        api :POST, "review", "Create a new review"

        review = current_user.reviews.new(review_params)
        if review.save
          render_message("Review Created successfully")
        else
          render_error(500, "Review didn't created successfully")
        end
      end

      api :PUT, "review", "Update a review"

      def update
        api :PUT, "review", "Update a review"

        review = Review.find(params[:id])
        if review.update(review_params)
          params[:review][:meals_attributes].each do |meal|
            if meal[:id].present? && meal[:_destroy].present?
              Meal.find(meal[:id]).delete
            else
              render_error(404, "Meal not found")
            end
          end
          render_message("Review updated successfully!")
        else
          render_error(500, "Review didn't updated")
        end
      end

      def create_review_with_num
        user = User.find_by(phone_number: params[:phone_number])
        rev_name = FetchTitleService.new(params[:review]['url'])
        if params[:phone_number].present? && user.present?
          review = user.reviews.new(name: rev_name.call, category_id: Category.find_by(name: "Others").id, to_try: true, url: params[:url])
          review.save ? message("#{request.env['rack.url_scheme']}://#{request.host_with_port}/reviews/#{review.slug}/edit") : review.errors.full_messages.first
        else
          message("check content type or user dose not exit with this phone number")
        end
      end

      private

      def validate_key
        message("invalid secret key") unless Rails.application.credentials.config[:x_api_key] == request.headers["x-api-key"]
      end

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

      def review_params
        params.require(:review).permit(:name, :category_id, :to_try, :shareable, :date, :tags, :address, :state, :city, :country, :zip_code, :latitude, :longitude, :place_id, :favorite_dish, :price_range, :cuisine, :average_score, :start_date, :end_date, :author, :platform, :url, :google_url, :foursquare_url, :yelp_url, :notes, images: [], meals_attributes: [:id, :name, :notes, :image_url, :_destroy])
      end

    end
  end
end