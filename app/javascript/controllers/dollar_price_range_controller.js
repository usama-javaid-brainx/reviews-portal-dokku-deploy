import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dollar"]

  priceRange(event) {
    this.dollarTargets.forEach((element) => {
      element.firstChild.classList.remove('bg-blue')
      if (element.firstChild.value <= event.currentTarget.firstChild.value) {
        element.firstChild.classList.add('bg-blue')
      }
    })
  }

}