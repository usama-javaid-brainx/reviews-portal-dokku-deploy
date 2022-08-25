import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["applyBtn", 'filtersForm', "cuisinesFilter", "tagsFilter"]

  connect() {
    this.filterCount = 0
    this.cuisines = [];
    this.filters = [];
    $(document).on('change', 'select', (e) => {
      this.filtersFormTarget.submit()
    })
  }

  selectCuisine(event) {
    var $cuisine = $(event.currentTarget).toggleClass('cuisine-select cuisine-unselect');
    $(event.currentTarget).toggleClass('clear-cuisine')

    if ($cuisine.hasClass('cuisine-select')) {
      this.cuisines.push(event.currentTarget.innerHTML)
      this.filterCount = this.filterCount + 1
    } else {
      this.cuisines = this.cuisines.filter(item => item !== event.currentTarget.innerHTML)
      this.filterCount = this.filterCount - 1
    }

    this.applyBtnTarget.innerHTML = 'Apply(' + this.filterCount.toString() + ')'
    // this.filterCount()

  }


  selectTag(event) {
    var $filters = $(event.currentTarget).toggleClass('cuisine-select cuisine-unselect');
    $(event.currentTarget).toggleClass('clear-tag')

    if ($filters.hasClass('cuisine-select')) {
      this.filters.push(event.currentTarget.innerHTML)
      this.filterCount = this.filterCount + 1
    } else {
      this.filters = this.filters.filter(item => item !== event.currentTarget.innerHTML)
      this.filterCount = this.filterCount - 1
    }

    this.applyBtnTarget.innerHTML = 'Apply(' + this.filterCount.toString() + ')'
    // this.filterCount()
  }

  cuisineClearAll() {
    this.clearAll('.clear-cuisine')
  }

  TagClearAll() {
    this.clearAll('.clear-tag')
  }

  clearAll(className) {
    let tags = document.querySelectorAll(className)
    tags.forEach(tag => {
      tag.classList.remove(className.split('.')[1])
      tag.classList.remove('cuisine-select')
      tag.classList.add('cuisine-unselect')
    })
  }

  filterCount() {
    this.applyBtnTarget.innerHTML = 'Apply(' + this.filterCount.toString() + ')'
  }

  applyFilter(){
    this.tagsFilterTarget.value = this.filters
    this.cuisinesFilterTarget.value = this.cuisines
    this.filtersFormTarget.submit()
  }
}