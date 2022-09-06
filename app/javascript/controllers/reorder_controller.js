import {Controller} from "@hotwired/stimulus"
import Sortable from "sortablejs";

export default class extends Controller {
  static targets = ["inputDiv"]

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    let input = this.inputDivTarget.getElementsByTagName("input")
    let imageTags = this.element.getElementsByTagName("img")
    for (let i = 0; imageTags.length >= i; i++) {
      input[i].value = imageTags[i].src
    }
  }
}