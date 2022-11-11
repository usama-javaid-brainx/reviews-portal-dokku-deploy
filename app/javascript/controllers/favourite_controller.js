import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['publicStatus']


  static values = {
    favouritePath: String,
    statusPath: String
  }

  updateFavourite(event) {
    let favouriteReview = $(event.currentTarget).toggleClass('checked')
    this.request(`favourite=${favouriteReview.hasClass('checked')}`)
  }

  request(data, favouriteBtn) {
    let that = this
    $.ajax({
      type: "GET",
      url: this.favouritePathValue,
      data: data,
      dataType: 'json',
      success() {
          window.location.reload();
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