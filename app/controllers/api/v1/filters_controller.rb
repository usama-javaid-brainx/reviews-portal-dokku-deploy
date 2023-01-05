module Api
  module V1
    class FiltersController < Api::V1::ApiController
      api :GET, "filters", "Get a list of all available filters"
      param :category_id, String, desc: "Category id for which filters are requested, if this is empty it will return filters from all reviews", required: false

      example <<-EOS
        
      Status Codes with Response
      200:{
          "sort_by": [
              {
                  "Newest": "recent"
              },
              {
                  "Top Rated": "desc"
              },
              {
                  "Low Rated": "asc"
              }
          ],
          "cuisines": [
              "afghan",
              "andalusian"
          ],
          "tags": [
              "great",
              "heavy",
              "hello world",
              "nice",
              "random"
          ],
          "locations": [
          {
            "city": "Aspen",
            "state": "CO",
            "country": "United States"
          },
          {
            "city": "",
            "state": "Ankara",
            "country": "Turkey"
          }
          ]
      }
      EOS

      def index
        reviews = params[:category_id].present? ? Review.where(category_id: params[:category_id]) : Review.all
        render json: { "sort_by": sort_by, "cuisines": cuisines(reviews), "tags": tags(reviews), "location": locations(reviews) }
      end

      private

      def sort_by
        [{ "Newest": 'recent' }, { "Top Rated": 'desc' }, { "Low Rated": 'asc' }]
      end

      def cuisines(reviews)
        reviews.pluck(:cuisine)
      end

      def tags(reviews)
        parse_reviews(reviews.pluck(:tags))
      end

      def locations(reviews)
        reviews.map do |review|
          if review.city.blank? && review.state.blank? && review.country.blank?
            next
          else
            {
              "city": review.city,
              "state": review.state,
              "country": review.country
            }
          end
        end
      end

    end
  end
end