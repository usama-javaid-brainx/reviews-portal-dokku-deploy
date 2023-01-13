module Api
  module V1
    class ReviewsController < Api::V1::ApiController
      skip_before_action :authenticate_user!, only: [:create_review_with_num]
      before_action :validate_key, only: [:create_review_with_num]

      api :POST, "reviews", "Get a list of current user reviews or with applied filters"
      param :page, String, desc: "Page number of the reviews you want to get", required: false

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
            "total_pages": 103
        }
    }

      EOS

      def index
        reviews = review_filter(current_user.reviews.includes(:sub_category, :meals))
        pagy, reviews = pagy(reviews)
        render json: reviews, meta: pagy_meta(pagy), each_serializer: ReviewSerializer, adapter: :json
      end

      api :POST, "reviews/create_review", "Create a new review"
      param :average_score, Integer, desc: "Should be between 1 to 10"
      param :price_range, Integer, desc: "Should be between 1 to 4"


      example <<-EOS
    {
        "id": 47,
        "user_id": 2,
        "name": "Arcadian Cafe",
        "address": "28 k Sir Syed Rd, Block K Gulberg 2, Lahore, Punjab, Pakistan",
        "city": "Lahore",
        "state": "Punjab",
        "country": "Pakistan",
        "place_id": "ChIJCfxBr_kEGTkR-1wlJ_OYM28",
        "longitude": "74.3493876",
        "latitude": "31.52254760000001",
        "favorite_dish": null,
        "average_score": 8.0,
        "notes": "sakdvbaskbdvkjasbdvckljasbdkjvcas.dkbcjsavdjchasd",
        "date": "2023-01-14",
        "created_at": "2022-09-15T11:13:51.514Z",
        "updated_at": "2023-01-12T15:20:46.683Z",
        "zip_code": "54646",
        "tags": [
            "tag 1",
            "tag 2"
        ],
        "price_range": 3,
        "status": null,
        "favourite": true,
        "shareable": true,
        "category_id": 1,
        "sub_category_id": null,
        "to_try": false,
        "discarded_at": null,
        "images": [
            "https://cdn.filestackcontent.com/jfx62MmZRmGcuWPFgUQh",
            "https://cdn.filestackcontent.com/iFWkHjXrTgGonIKj3U7f"
        ],
        "parent_id": null,
        "slug": "arcadian-cafe-47",
        "start_date": "2023-01-14",
        "end_date": "2023-01-17",
        "author": "Harry Potter",
        "platform": "",
        "url": "",
        "google_url": "",
        "foursquare_url": "",
        "yelp_url": "",
        "meals": [
            {
                "id": 40,
                "name": "Ywwwwwwes",
                "notes": "This is note 1",
                "image_url": "image_url",
                "created_at": "2022-12-28T10:45:31.151Z",
                "updated_at": "2023-01-12T13:59:47.243Z",
                "review_id": 47
            }
        ]
    }

      EOS

      def create_review
        review = current_user.reviews.new(review_params)
        if review.save
          render json: review, adapter: :json
        else
          render_error(422, review.errors.full_messages)
        end
      end

      api :PUT, "reviews/:id", "Update a review with an id"

      example <<-EOS
          {
              "name": "Arcadian Cafe",
              "category_id": "1",
              "sub_category_id": "",
              "to_try": "false",
              "shareable": "true",
              "date": "2023-01-14",
              "tags": ["tag 1", "tag 2"],
              "address": "28 k Sir Syed Rd, Block K Gulberg 2, Lahore, Punjab, Pakistan",
              "state": "Punjab",
              "city": "Lahore",
              "country": "Pakistan",
              "zip_code": "54646",
              "latitude": "31.52254760000001",
              "longitude": "74.3493876",
              "place_id": "ChIJCfxBr_kEGTkR-1wlJ_OYM28",
              "price_range": "3",
              "average_score": "8",
              "start_date": "2023-01-14",
              "end_date": "2023-01-17",
              "author": "Harry Potter",
              "platform": "",
              "url": "",
              "google_url": "",
              "foursquare_url": "",
              "yelp_url": "",
              "notes": "sakdvbaskbdvkjasbdvckljasbdkjvcas.dkbcjsavdjchasd",
              "images": [
                  "https://cdn.filestackcontent.com/jfx62MmZRmGcuWPFgUQh",
                  "https://cdn.filestackcontent.com/iFWkHjXrTgGonIKj3U7f"
              ],
              "meals_attributes": [
                  {
                      "id": "43",
                      "name": "Ywwwwwwes",
                      "notes": "This is note 1",
                      "image_url": "image_url",
                      "_destroy": "true"
                  }
              ]
          }
      EOS

      def update
        review = Review.find(params[:id])
        if review.update(review_params)
          render json: review, each_serializer: ReviewSerializer, adapter: :json
        else
          render_error(422, review.errors.full_messages)
        end
      end

      def create_review_with_num
        user = User.find_by(phone_number: params[:phone_number])
        rev_name = FetchTitleService.new(params[:review]['url'])
        if params[:phone_number].present? && user.present?
          review = user.reviews.new(name: rev_name.call, category_id: Category.find_by(name: "Others").id, to_try: true, url: params[:url])
          review.save ? message("#{request.env['rack.url_scheme']}://#{request.host_with_port}/reviews/#{review.slug}/edit") : review.errors.full_messages
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
        reviews = reviews.where(category_id: params[:filters][:category_id]) if params[:filters][:category_id].present?
        reviews = reviews.where(to_try: params[:filters][:to_try]) if params[:filters][:to_try].present?
        reviews = reviews.where('tags ilike any (array[?])', params[:filters][:tags].map { |str| "%,#{str}%" }) if params[:filters][:tags].present?
        reviews = location_filter(reviews) if params[:filters][:location].present?
        reviews = reviews.ransack(name_or_state_or_city_or_country_or_tags_or_notes_or_sub_category_name_i_cont_any: params[:filters][:query]).result(distinct: true) if params[:filters][:query].present?
        reviews = reviews.ransack(sub_category_name_i_cont_any: params[:filters][:sub_category_names]).result(distinct: true) if params[:filters][:sub_category_names].present?
        reviews = if params[:filters][:order].present?
                    reviews.order(params[:filters][:order] == "recent" ? "created_at desc" : "average_score #{params[:filters][:order]} NULLS LAST")
                  else
                    reviews.order(Arel.sql("CASE WHEN date IS NOT NULL THEN date WHEN start_date IS NOT NULL THEN start_date ELSE created_at END"))
                  end
        reviews
      end

      def location_filter(reviews)
        location_obj = {
          "cities": [],
          "states": [],
          "countries": []
        }
        params[:filters][:location].each do |obj|
          location_obj[:cities] << obj[:city] if obj[:city].present?
          location_obj[:states] << obj[:state] if obj[:state].present?
          location_obj[:countries] << obj[:country] if obj[:country].present?
        end
        reviews = reviews.where(state: location_obj[:states].uniq) if location_obj[:states].present?
        reviews = reviews.where(city: location_obj[:cities].uniq) if location_obj[:cities].present?
        reviews = reviews.where(country: location_obj[:countries].uniq) if location_obj[:countries].present?
        reviews
      end

      def review_params
        "<p>#{params[:review][:notes]}<p>" if params[:review][:notes].present?
        params.require(:review).permit(:name, :category_id, :sub_category_id, :to_try, :shareable, :date, :address, :state, :city, :country, :zip_code, :latitude, :longitude, :place_id, :favorite_dish, :price_range, :average_score, :start_date, :end_date, :author, :platform, :url, :google_url, :foursquare_url, :yelp_url, :notes, images: [], meals_attributes: [:id, :name, :notes, :image_url, :_destroy]).merge(tags: params[:tags].present? ? params[:tags].join(',') : "")
      end

    end
  end
end
