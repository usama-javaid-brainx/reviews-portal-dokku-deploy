import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card-select", "hiddenCheckbox"]
  static values = {search: String, newgroup: String, editgroup: String }

  search(event) {
    let searchData = `search=${event.currentTarget.value}`
    this.searchRequest(searchData)
  }

  searchRequest(searchData) {
    let that = this
    $.ajax({
      type: "GET",
      url: this.searchValue,
      data: searchData,
      dataType: 'json',
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
    debugger
    let groupId = event.currentTarget.getAttribute("data-groupId")
    let finalUrl = !groupId ? this.newgroupValue : `${this.newgroupValue}?id=${groupId}`
    $.ajax({
      type: "GET",
      url: finalUrl
    })
  }

  // editGroup(event) {
  //   var editLocation = event.currentTarget.getAttribute("data-editgroup")
  //   this.editRequest(editLocation)
  // }
  //
  // editRequest(editLocation) {
  //   let that = this
  //   $.ajax({
  //     type: "GET",
  //     url: this.editLocation
  //   })
  // }
}