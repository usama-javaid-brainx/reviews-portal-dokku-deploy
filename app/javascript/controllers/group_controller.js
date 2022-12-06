import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card-select"]
  static values = {search: String, newgroup: String }

  searchRequest(event) {
    this.reviewSearchControllers.forEach(controller => {controller.element.classList.remove('d-none')})
    if (event.currentTarget.value != ""){
      this.reviewSearchControllers.forEach(controller => {
        let valuePresence = controller.nameValue.toLowerCase().includes(event.currentTarget.value.toLowerCase())
        if (valuePresence == false){
          controller.element.classList.add('d-none')
        }
      })
    }

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