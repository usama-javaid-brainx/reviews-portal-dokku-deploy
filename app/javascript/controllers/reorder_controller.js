import {Controller} from "@hotwired/stimulus"
import Sortable from "sortablejs";

export default class extends Controller {
  static targets = [ "inputDiv" ]


  connect() {
    this.sortable = Sortable.create(this.element,{
    onEnd: this.end.bind(this)
    })
  }
  end(event) {
    debugger
    console.log(this.inputDivTarget)
    console.log(event)
  }
}