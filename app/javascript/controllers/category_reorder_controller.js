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
    let oldIndex = event.oldIndex
    let newIndex = event.newIndex
    let dragableElements = event.target.children
    if (oldIndex < newIndex) {
      let i = oldIndex
      while (i < newIndex) {
        dragableElements[i].id = dragableElements[i].id - 1
        i++
      }
      dragableElements[newIndex].id = parseInt(dragableElements[i - 1].id) + 1
    } else {
      let i = oldIndex
      while (i > newIndex) {
        dragableElements[i].id = parseInt(dragableElements[i].id) + 1
        i--
      }
      dragableElements[newIndex].id = dragableElements[i + 1].id - 1
    }
    for(let i = 0; i < dragableElements.length; i++){
      dragableElements[i].firstElementChild.value = i+1
    }
  }
}