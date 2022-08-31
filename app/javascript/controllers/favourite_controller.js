import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    favouritePath: String
  }

  updateFavourite(event) {
    var $favouriteReview = $(event.currentTarget).toggleClass('checked')
    if ($favouriteReview.hasClass('checked')) {
      this.request("GET", this.favouritePathValue, "favourite=true")
    } else {
      this.request("GET", this.favouritePathValue, "favourite=false")
    }
  }

  request(type, url, data) {
    $.ajax({
      type: type,
      url: url,
      data: data,
      dataType: 'json'
    })
  }
}