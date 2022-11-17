import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['favoriteLink', 'publicStatus']

  static values = {
    likedPath: String,
    statusPath: String
  }

  updateFavourite(event) {
    let favouriteReview = $(event.currentTarget).toggleClass('checked')
    this.request(`favourite=${favouriteReview.hasClass('checked')}`)
    window.location.reload();
  }

  request(data, favouriteBtn) {
    let that = this
    $.ajax({
      type: "GET",
      url: this.likedPathValue,
      data: data,
      dataType: 'json',
      success() {
        if (that.hasFavoriteLinkTarget) {
          location.reload()
        }
      }
    })
  }

  updateReviewStatus(event) {
    let reviewStatus = !(this.publicStatusTarget.checked)
    $.ajax({
      type: "GET",
      url: this.statusPathValue,
      data: {share: reviewStatus},
      success() {
        window.location.reload()
      }
    })
  }
}