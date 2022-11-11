import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

  static values = {
    favouritePath: String
  }

  updateFavourite(event) {
    let favouriteReview = $(event.currentTarget).toggleClass('checked')
    this.request(`favourite=${favouriteReview.hasClass('checked')}`)
  }

  request(data, favouriteBtn) {
    let that = this
    $.ajax({
      type: "GET",
      url: that.favouritePathValue,
      data: data,
      dataType: 'json',
      success() {
          window.location.reload();
      }
    })
  }
}