import {Controller} from "@hotwired/stimulus"
import Sortable from "sortablejs";

export default class extends Controller {

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    let id = event.item.dataset.id
    let data = new FormData()
    data.append("position", event.newIndex + 1)
    $.ajax({
      url: this.data.get("url").replace(":id", id),
      processData: false,
      contentType: false,
      cache: false,
      type: 'PATCH',
      data: data
    })
  }
}