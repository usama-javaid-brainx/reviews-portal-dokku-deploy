import {Controller} from "@hotwired/stimulus"
import Sortable from "sortablejs";

export default class extends Controller {
  // static targets = ["inputDiv"]

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.reorderingInputs.bind(this)
    })
  }

  reorderingInputs(event) {
    let inputs = this.element.getElementsByClassName("image-inputs")
    let imageTags = this.element.getElementsByTagName("img")
    for (let i = 0; imageTags.length > i; i++) {
      inputs[i].value = imageTags[i].src
    }
  }
}