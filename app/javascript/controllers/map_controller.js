import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["score", 'yelpScore', 'yelpRating', 'yelpReviews', 'foursquareScore', 'foursquareRating', 'foursquareReviews', 'googleScore', 'googleRating', 'googleReviews', 'scoreLoading']

  static values = {
    latitude: String,
    longitude: String,
    getscoreurl: String
  }

  connect() {
    let foursquareUrl = $('div[data-foursquareUrl]').attr('data-foursquareUrl')
    if (foursquareUrl != "") {
      this.getScore(foursquareUrl)
    }
  }

  openMap() {
    window.open(`https://maps.google.com/?q=${this.latitudeValue},${this.longitudeValue}`, '_blank')
  }

  getScore(foursquareUrl) {
    let that = this
    let url = this.getscoreurlValue
    $.ajax({
      type: "GET",
      url: url,
      data: `foursquare_yelp_url=${foursquareUrl}`,
      dataType: 'json',
      success(response) {
        that.displayScore(response)

      }
    })
  }

  displayScore(ratings) {
    this.displayScoreBlock(this.yelpScoreTarget, this.yelpRatingTarget, this.yelpReviewsTarget, 'yelp', ratings)
    this.displayScoreBlock(this.foursquareScoreTarget, this.foursquareRatingTarget, this.foursquareReviewsTarget, 'foursquare', ratings)
  }

  displayScoreBlock(scoreTarget, ratingTarget, reviewsTarget, scoreType, ratings) {

    if (ratings[0][scoreType]['ratings'] != '') {
      this.scoreTarget.classList.remove('d-none')
      this.scoreLoadingTarget.classList.add('d-none')
      scoreTarget.classList.remove('d-none')
      ratingTarget.innerHTML = ratings[0][scoreType]['ratings']
      reviewsTarget.innerHTML = `${ratings[0][scoreType]['reviews']} reviews`
    }
  }
}