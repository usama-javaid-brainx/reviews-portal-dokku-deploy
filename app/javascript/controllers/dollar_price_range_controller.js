import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dollar"]

  priceRange(event) {
    this.dollarTargets.forEach((element) => {
      let childElement = element.firstChild
      childElement.classList.remove('bg-blue')
      if (childElement.value <= event.currentTarget.firstChild.value) {
        childElement.classList.add('bg-blue')
      }
    })
  }

}