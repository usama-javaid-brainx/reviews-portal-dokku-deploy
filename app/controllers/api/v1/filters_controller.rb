module Api
  module V1
    class FiltersController < Api::V1::ApiController
      skip_before_action :authenticate_user!, only: [:index]
      api :GET, "filters", "Get a list of all available filters"
      def index
        reviews = params[:category_id].present? ? Review.where(category_id: params[:category_id]) : Review.all
        sort_by = [{"Newest": 'recent'}, {"Top_Rated": 'desc'}, {"Low_Rated": 'asc'}]
        cuisines = reviews.pluck(:cuisine).map { |cuisine| cuisine.split(",") }.flatten.collect { |e| e.strip.downcase }.uniq.reject(&:empty?).sort
        tags = reviews.pluck(:tags).map { |tags| tags.split(",") }.flatten.collect { |e| e.strip.downcase }.uniq.reject(&:empty?).sort
        locations = []
        reviews.each do |review|
          unless review.city.nil? && review.state.nil?
            locations << (review.city + ' . ' + review.state)
          end
        end
        locations.map { |loc| loc.split(",") }.flatten.collect { |e| e.strip.downcase }.uniq.reject(&:empty?).sort
        filters = [{"sort_by": sort_by}, {"cuisines": cuisines}, {"tags": tags}, {"locations": locations}]
        render json: filters, adapter: :json
      end
    end
  end
end