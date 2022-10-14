class FetchUrlJob < ApplicationJob
  queue_as :default

  def perform(review, location, name)
    options = { body: {location: location, "limit": 1, query: name}}
    response = HTTParty.get('https://yelp-foursquare-api.herokuapp.com/api/v1/placesByLocations/', options)
    url = response["result"]["links"].first
    if url.present?
      review.update(foursquare_url: url)
    end
  end
end
