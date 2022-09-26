import {Controller} from "@hotwired/stimulus"
import Sortable from "sortablejs";

export default class extends Controller {

  static values = { position: Number }

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.changePosition.bind(this)
    })
  }

  changePosition(event) {
    let dragableElements = event.target.children
    $('.drag-field').each((i, elem) => {
      elem.id = i + 1
    });
    for(let i = 0; i < dragableElements.length; i++){
      dragableElements[i].firstElementChild.value = i+1
    }
  }
}
