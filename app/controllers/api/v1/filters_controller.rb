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
              "frankfurt . he",
              "lahore . punjab",
              "paris . idf"
          ]
      }
      EOS

      def index
        reviews = params[:category_id].present? ? Review.where(category_id: params[:category_id]) : Review.all
        render json: { "sort_by": sort_by, "cuisines": cuisines(reviews), "tags": tags(reviews), "locations": locations(reviews) }
      end

      private

      def sort_by
        [{ "Newest": 'recent' }, { "Top Rated": 'desc' }, { "Low Rated": 'asc' }]
      end

      def cuisines(reviews)
        parse_reviews(reviews.pluck(:cuisine))
      end

      def tags(reviews)
        parse_reviews(reviews.pluck(:tags))
      end

      def locations(reviews)
        locations = []
        reviews.each do |review|
          (review.city.nil? && review.state.nil?) ? next : locations << (review.city + ' . ' + review.state)
        end
        parse_reviews(locations)
      end

    end
  end
end