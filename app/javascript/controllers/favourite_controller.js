import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['publicStatus']

  static values = {
    likedPath: String,
    statusPath: String
  }

  updateFavourite(event) {
    debugger
    let favouriteReview = $(event.currentTarget).toggleClass('checked')
    if(event.currentTarget.classList.contains("checked")){
      event.currentTarget.firstElementChild.src = event.currentTarget.getAttribute("data-fill-heart-icon")
    }
    else{
      event.currentTarget.firstElementChild.src = event.currentTarget.getAttribute("data-empty-heart-icon")
    }
    this.request(`favourite=${favouriteReview.hasClass('checked')}`)
  }
  request(data) {
    $.ajax({
      type: "GET",
      url: this.likedPathValue,
      data: data
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