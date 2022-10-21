import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["applyBtn", 'filtersForm', "cuisinesFilter", "tagsFilter", 'appliedFilter', "input"]

  openMap() {
    window.open("https://maps.google.com/?q=25.2048493,55.2707828", '_blank')
  }
}