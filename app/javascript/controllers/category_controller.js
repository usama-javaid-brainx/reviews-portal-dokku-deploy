import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "category" , "input"]

  categorySelect(){
    window.location.href = `${window.location.href.split('?')[0]}?category_id=${this.categoryTarget.value}`
  }

  fieldDisplay(){
    this.inputTarget.classList.remove("d-none")
  }

  navbarSearch(event) {
    if (event.key === "Enter") {
      this.filtersFormTarget.submit()
    }
  }

}