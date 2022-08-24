import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["applyBtn", 'filtersForm']

  connect() {
    $(document).on('change', 'select', (e) => {
      this.filtersFormTarget.submit()
    })
  }

  cuisine(event) {
    $(event.currentTarget).toggleClass('cuisine-select cuisine-unselect');
    $(event.currentTarget).toggleClass('clear-cuisine  ')

  }


  cuisineTag(event) {
    $(event.currentTarget).toggleClass('cuisine-select cuisine-unselect');
    $(event.currentTarget).toggleClass('clear-tag  ')
  }

  cuisineClearAll() {
    this.clearAll('.clear-cuisine')
  }

  TagClearAll() {
    this.clearAll('.clear-tag')
  }

  clearAll(className) {
    let tags = document.querySelectorAll(className)
    tags.forEach( tag =>{
      tag.classList.remove(className.split('.')[1])
      tag.classList.remove('cuisine-select')
      tag.classList.add('cuisine-unselect')
    })
  }

  submit(){
  }
}