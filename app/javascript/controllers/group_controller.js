import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card-select", "searchField"]
  static values = {search: String, newgroup: String}

  searchRequest(event) {
    let val = this.searchFieldTarget.value
    this.reviewSearchControllers.forEach(controller => {
      controller.element.classList.remove('d-none')
      if (val != "") {
        if (!(controller.nameValue.toLowerCase().includes(val.toLowerCase()))) {
          controller.element.classList.add('d-none')
        }
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

  get reviewSearchControllers() {
    return this.application.controllers.filter(controller => {
      return controller.context.identifier === 'review-search'
    })
  }

}