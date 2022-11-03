import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card-select", "hiddenCheckbox"]
  static values = {search: String, newgroup: String, editgroup: String }

  search(event) {
    let searchData = event.currentTarget.value
    this.searchRequest(searchData)
  }

  searchRequest(searchData) {
    $.ajax({
      type: "GET",
      url: this.searchValue,
      data: {search: searchData},
      success(response) {
        console.log(response[0].search_reviews)
      }
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