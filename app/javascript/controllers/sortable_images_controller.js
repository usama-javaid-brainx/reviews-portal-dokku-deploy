import {Controller} from "@hotwired/stimulus"
import Sortable from "sortablejs";

export default class extends Controller {

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.reorderingInputs.bind(this)
    })
  }

  reorderingInputs(event) {
    debugger
    let inputs = this.element.getElementsByClassName("image-inputs")
    let imageTags = this.element.getElementsByClassName("small-thumb")
    for (let i = 0; imageTags.length > i; i++) {
      inputs[i].value = imageTags[i].src
    }
  }
}