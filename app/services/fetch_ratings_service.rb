class FetchRatingsService

  def initialize(url)
    @geolocations = ['foursquare', 'yelp']
    @url = url
  end

  def call
    foursquare_yelp = []
    @geolocations.each do |geolocation|
      foursquare_yelp.push(fetch_ratings(geolocation, @url))
    end
    [foursquare: foursquare_yelp.first, yelp: foursquare_yelp.second]
  end

  def fetch_ratings(type, url)
    options = { body: {
      "url": url,
      "type": type
    } }
    response = HTTParty.get('https://yelp-foursquare-api.herokuapp.com/api/v1/', options)
    response["result"]
  end
end