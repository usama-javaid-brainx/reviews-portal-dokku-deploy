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
    this.cuisines = this.selectParam(event, 'clear-cuisine', this.cuisines)
  }

  selectTag(event) {
    this.filters = this.selectParam(event, 'clear-tag', this.filters)
  }

  selectParam(e, clearClass, filterType) {
    $(e.currentTarget).toggleClass(clearClass)
    let selectedTag = $(e.currentTarget).toggleClass('cuisine-select cuisine-unselect');
    if (selectedTag.hasClass('cuisine-select')) {
      filterType.push(e.currentTarget.innerHTML)
      this.filterCount = this.filterCount + 1
    } else {
      filterType = filterType.filter(item => item !== e.currentTarget.innerHTML)
      if (this.filterCount - 1 >= 0) {
        this.filterCount = this.filterCount - 1
      }
    }
    this.applyBtnTarget.innerHTML = 'Apply(' + this.filterCount.toString() + ')'
    return filterType
  }

  cuisineClearAll() {
    this.clearAll('clear-cuisine')
    this.cuisines = []
  }

  TagClearAll() {
    this.clearAll('clear-tag')
    this.filters = []
  }

  clearAll(className) {
    let tags = document.querySelectorAll(`.${className}`)
    tags.forEach(tag => {
      tag.classList.remove(className, 'cuisine-select')
      tag.classList.add('cuisine-unselect')
    })
  }

  filterCount() {
    this.applyBtnTarget.innerHTML = 'Apply(' + this.filterCount.toString() + ')'
  }

  applyFilter() {
    this.tagsFilterTarget.value = this.filters
    if (this.hasCuisinesFilterTarget) {            //cuisines can be present or not in modal
      this.cuisinesFilterTarget.value = this.cuisines
    }
    this.filtersFormTarget.submit()
  }

  appliedFilters() {
    let appliedFilters = 0
    if (this.hasCuisinesFilterTarget) {
      appliedFilters = this.cuisinesFilterTarget.value.split(',').filter(x => x != '').length + this.tagsFilterTarget.value.split(',').filter(x => x != '').length
    } else {
      appliedFilters = this.tagsFilterTarget.value.split(',').filter(x => x != '').length
    }
    if (appliedFilters > 0) {
      this.appliedFilterTarget.innerHTML = appliedFilters
      this.appliedFilterTarget.classList.add('cuisine-select', 'ml-2', 'px-2', 'rounded-3')
      this.applyBtnTarget.innerHTML = `Apply(${appliedFilters.toString()})`
      this.filterCount = appliedFilters
      if (this.hasCuisinesFilterTarget) {
        this.cuisines = this.cuisinesFilterTarget.value.split(',').filter(x => x != '')
      }
      this.filters = this.tagsFilterTarget.value.split(',').filter(x => x != '')
    }
  }

  search(event) {
    if (event.key === "Enter") {
      this.filtersFormTarget.submit()
    }
  }
}