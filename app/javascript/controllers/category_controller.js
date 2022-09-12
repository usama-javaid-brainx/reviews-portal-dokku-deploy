import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "category" ]

  categorySelect(){
    window.location.href = `${window.location.href.split('?')[0]}?category_id=${this.categoryTarget.value}`
  }
}