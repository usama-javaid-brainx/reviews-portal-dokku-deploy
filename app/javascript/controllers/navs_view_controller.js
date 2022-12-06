import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["navGrid", "navList"]

  listView() {
    localStorage.setItem('view', 'list');
  }

  gridView() {
    localStorage.setItem('view', 'grid');
  }

}