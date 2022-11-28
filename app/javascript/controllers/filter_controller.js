import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["applyBtn", 'filtersForm', 'locationFilter', "cuisinesFilter", "tagsFilter", 'appliedFilter', "input", 'sortReviews', 'scoreFilter', 'sortDropdown']

  connect() {
    this.filterCount = 0
    this.cuisines = [];
    this.filters = [];
    this.location = [];
    if(this.hasLocationFilterTarget) {
      this.appliedFilters()
    }
    if (this.hasSortReviewsTarget) {
      $(this.sortReviewsTarget).select2({
        minimumResultsForSearch: Infinity,
        dropdownParent: $("#filterModal")
      });
      $(this.sortReviewsTarget).on('select2:select select2:unselect', this.reviewSort.bind(this))
    }
    if (this.hasSortDropdownTarget) {
      $(this.sortDropdownTarget).select2({
        minimumResultsForSearch: Infinity
      })
      $(this.sortDropdownTarget).on('select2:select select2:unselect', this.sortDropdown.bind(this))
      $(document).on('turbo:before-cache', function () {
        $("#score").select2('destroy');
      });
    }
  }

  selectLocation(event) {
    this.location = this.selectParam(event, 'clear-location', this.location)
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
      filterType.push(e.currentTarget.innerHTML.replace(/&amp;/g, '&'))
      this.filterCount = this.filterCount + 1
    } else {
      filterType = filterType.filter(item => item !== e.currentTarget.innerHTML.replace(/&amp;/g, '&'))
      if (this.filterCount - 1 >= 0) {
        this.filterCount = this.filterCount - 1
      }
    }
    this.applyBtnTarget.innerHTML = 'Apply(' + this.filterCount.toString() + ')'
    return filterType
  }

  locationClearAll() {
    this.clearAll('clear-location')
    this.location = []
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
    this.locationFilterTarget.value = this.location
    if (this.hasCuisinesFilterTarget) {            //cuisines can be present or not in modal
      this.cuisinesFilterTarget.value = this.cuisines
    }
    this.filtersFormTarget.submit()
  }

  appliedFilters() {
    let appliedFilters = 0
    appliedFilters = this.locationFilterTarget.value.split(',').filter(x => x != '').length + this.cuisinesFilterTarget.value.split(',').filter(x => x != '').length + this.tagsFilterTarget.value.split(',').filter(x => x != '').length

    if (appliedFilters > 0) {
      this.appliedFilterTarget.innerHTML = appliedFilters
      this.appliedFilterTarget.classList.add('cuisine-select', 'ml-2', 'px-2', 'rounded-3')
      this.applyBtnTarget.innerHTML = `Apply(${appliedFilters.toString()})`
      this.filterCount = appliedFilters
      this.location = this.locationFilterTarget.value.split(',').filter(x => x != '')
      this.cuisines = this.cuisinesFilterTarget.value.split(',').filter(x => x != '')
      this.filters = this.tagsFilterTarget.value.split(',').filter(x => x != '')
    }
  }

  fieldDisplay(event) {
    this.inputTarget.classList.contains("search-input-expand") ? this.inputTarget.classList.remove("search-input-expand") : this.inputTarget.classList.add("search-input-expand")
  }

  search(event) {
    if (event.key === "Enter") {
      this.filtersFormTarget.submit()
    }
  }

  reviewSort() {
    this.scoreFilterTarget.value = this.sortReviewsTarget.value
  }

  sortDropdown() {
    this.filtersFormTarget.submit()
  }

  showMap(event) {
    let view = this.mapViewController
    if (event.currentTarget.checked) {
      this.mapOn(view)
    } else {
      this.mapOff(view)
    }
  }

  mapOn(view) {
    for (let i = 0; i < view.allReviewsTargets.length; i++) {
      view.allReviewsTargets[i].classList.remove("col-lg-12")
      view.allReviewsTargets[i].classList.add("grid-review-card", "col-lg-6")
      view.mapViewTargets[i].classList.remove("d-none")
    }
    for (let i = 0; i < view.gridReviewCardTargets.length; i++) {
      if (view.hasListReviewCardTarget) {
        view.listReviewCardTargets[i].classList.remove("col-lg-12")
      }
      view.gridReviewCardTargets[i].classList.remove("col-lg-3")
    }
  }

  mapOff(view) {
    for (let i = 0; i < view.allReviewsTargets.length; i++) {
      view.allReviewsTargets[i].classList.add("col-lg-12")
      view.allReviewsTargets[i].classList.remove("grid-review-card", "col-lg-6")
      view.mapViewTargets[i].classList.add("d-none")
    }
    for (let i = 0; i < view.gridReviewCardTargets.length; i++) {
      if (view.hasListReviewCardTarget) {
        view.listReviewCardTargets[i].classList.add("col-lg-12")
      }
      view.gridReviewCardTargets[i].classList.add("col-lg-3")
    }
  }

  get mapViewController() {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === 'map-view'
    })
  }
}