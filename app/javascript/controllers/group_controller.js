import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card-select"]
  static values = {search: String, newgroup: String }

  searchRequest(event) {
    let searchData = event.currentTarget.value
    let that = this
    $.ajax({
      type: "GET",
      url: this.searchValue,
      data: {search: searchData}
    })
  }

  cardSelect(event) {
    if (event.currentTarget.classList.contains("review-card-select")) {
      event.currentTarget.classList.remove("review-card-select")
      event.currentTarget.querySelector("input").checked = false
    } else {
      event.currentTarget.classList.add("review-card-select")
      event.currentTarget.querySelector("input").checked = true
    }
  }

  newRequest(event) {
    let groupId = event.currentTarget.getAttribute("data-groupId")
    let finalUrl = !groupId ? this.newgroupValue : `${this.newgroupValue}?id=${groupId}`
    $.ajax({
      type: "GET",
      url: finalUrl
    })
  }
}