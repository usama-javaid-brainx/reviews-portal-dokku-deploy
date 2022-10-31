import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["score", 'yelpScore', 'yelpRating', 'yelpReviews', 'foursquareScore', 'foursquareRating', 'foursquareReviews', 'googleScore', 'googleRating', 'googleReviews', 'scoreLoading']

  static values = {
    location: String,
    getscoreurl: String
  }

  connect() {
    this.scoreBlock = 0
    let foursquareUrl = $('div[data-foursquareUrl]').attr('data-foursquareUrl')
    if (foursquareUrl != "") {
      this.getScore(foursquareUrl)
    }else{
      this.scoreTarget.classList.add('d-none')
    }
  }

  openMap() {
    window.open(`https://maps.google.com/?q=${this.locationValue}`, '_blank')
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
    if( this.scoreBlock == 0){
      this.scoreTarget.classList.add('d-none')
    }else{
      this.scoreTarget.classList.remove('d-none')
    }
  }

  displayScoreBlock(scoreTarget, ratingTarget, reviewsTarget, scoreType, ratings) {
    if (ratings[0][scoreType] != null && parseFloat(ratings[0][scoreType]['ratings']) >= 0 && parseFloat(ratings[0][scoreType]['ratings']) <= 10) {
      this.scoreTarget.classList.remove('d-none')
      this.scoreLoadingTarget.classList.add('d-none')
      scoreTarget.classList.remove('d-none')
      ratingTarget.innerHTML = ratings[0][scoreType]['ratings']
      reviewsTarget.innerHTML = `${ratings[0][scoreType]['reviews']} reviews`
      this.scoreBlock = 1
    }
  }
}