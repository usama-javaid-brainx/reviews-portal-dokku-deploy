import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["applyBtn", 'filtersForm', "cuisinesFilter", "tagsFilter", 'appliedFilter']

  connect() {
    this.filterCount = 0
    this.cuisines = [];
    this.filters = [];
    $(document).on('change', 'select', (e) => {
      this.filtersFormTarget.submit()
    })
    this.appliedFilters()
  }

  selectCuisine(event) {
    var $cuisine = $(event.currentTarget).toggleClass('cuisine-select cuisine-unselect');
    $(event.currentTarget).toggleClass('clear-cuisine')

    if ($cuisine.hasClass('cuisine-select')) {
      this.cuisines.push(event.currentTarget.innerHTML)
      this.filterCount = this.filterCount + 1
    } else {
      this.cuisines = this.cuisines.filter(item => item !== event.currentTarget.innerHTML)
      if (this.filterCount - 1 >= 0) {
        this.filterCount = this.filterCount - 1
      }
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
      if (this.filterCount - 1 >= 0) {
        this.filterCount = this.filterCount - 1
      }

    }

    this.applyBtnTarget.innerHTML = 'Apply(' + this.filterCount.toString() + ')'
    // this.filterCount()
  }

  cuisineClearAll() {
    this.clearAll('.clear-cuisine')
    this.cuisines = []
  }

  TagClearAll() {
    this.clearAll('.clear-tag', 'filters')
    this.filters = []
  }

  clearAll(className, filter) {
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

  applyFilter() {
    this.tagsFilterTarget.value = this.filters
    if (this.hasCuisinesFilterTarget){            //cuisines can be present or not in modal
      this.cuisinesFilterTarget.value = this.cuisines
    }
    this.filtersFormTarget.submit()
  }

  appliedFilters() {
    let appliedFilters = 0
    if (this.hasCuisinesFilterTarget){
      appliedFilters = this.cuisinesFilterTarget.value.split(',').filter(x => x != '').length + this.tagsFilterTarget.value.split(',').filter(x => x != '').length
    }
    else{
      appliedFilters = this.tagsFilterTarget.value.split(',').filter(x => x != '').length
    }

    if (appliedFilters > 0) {
      this.appliedFilterTarget.innerHTML = appliedFilters
      this.appliedFilterTarget.classList.add('cuisine-select', 'ml-2', 'px-2', 'rounded-3')

      this.applyBtnTarget.innerHTML = 'Apply(' + appliedFilters.toString() + ')'

      this.filterCount = appliedFilters
      if (this.hasCuisinesFilterTarget){ this.cuisines = this.cuisinesFilterTarget.value.split(',').filter(x => x != '') }
      this.filters = this.tagsFilterTarget.value.split(',').filter(x => x != '')
    }
  }
}