import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    favouritePath: String
  }

  updateFavourite(event) {
    let favouriteReview = $(event.currentTarget).toggleClass('checked')
    this.request(`favourite=${favouriteReview.hasClass('checked')}`)
  }

  request(data) {
    $.ajax({
      type: "GET",
      url: this.favouritePathValue,
      data: data,
      dataType: 'json'
    })
  }
}