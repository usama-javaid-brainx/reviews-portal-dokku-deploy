module Api
  module V1
    class FiltersController < Api::V1::ApiController
      api :GET, "filters", "Get a list of all available filters"
      param :category_id, Integer, desc: "Category id for which filters are requested, if this is empty it will return filters from all reviews", required: false

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
          "sub_category_names": {
              "cuisine": [],
              "genre": [
                  "Heist",
                  "Action"
              ]
          },
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
        @reviews = params[:category_id].present? ? Review.where(category_id: params[:category_id]) : Review.all
        render json: { "sort_by": sort_by, "sub_category_names": sub_category_names, "tags": tags, "location": locations }
      end

      private

      def sort_by
        [{ "Newest": 'recent' }, { "Top Rated": 'desc' }, { "Low Rated": 'asc' }]
      end

      def sub_category_names
        joined_reviews = @reviews.joins(:sub_category).distinct
        category = Category.find_by(name: 'Restaurants')
        {
          cuisine: joined_reviews.where(category_id: category.id).pluck("sub_categories.name"),
          genre: joined_reviews.where.not(category_id: category.id).pluck("sub_categories.name")
        }
      end

      def tags
        parse_reviews(@reviews.pluck(:tags))
      end

      def locations
        @reviews.map do |review|
          next if review.city.blank? && review.state.blank? && review.country.blank?
          {
            "city": review.city,
            "state": review.state,
            "country": review.country
          }
        end.compact
      end

    end
  end
end