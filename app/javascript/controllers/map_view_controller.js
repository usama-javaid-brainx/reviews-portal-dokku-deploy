import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["allReviews", "listView", "gridView", "gridReviewCard", "listReviewCard", "mapView"]

  connect() {
    if (this.navsViewController != undefined) {
      if (localStorage.getItem("view") == "grid" || localStorage.getItem("view") == "") {
        this.toggle(this.navsViewController.navGridTarget, this.navsViewController.navListTarget)
        this.toggle(this.gridViewTarget, this.listViewTarget)
      } else {
        this.toggle(this.navsViewController.navListTarget, this.navsViewController.navGridTarget)
        this.toggle(this.listViewTarget, this.gridViewTarget)
      }
    }
  }

  toggle(classAddTarget, classRemoveTarget) {
    classAddTarget.classList.add("active")
    classRemoveTarget.classList.remove("active")
  }

  get navsViewController() {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === 'navs-view'
    })
  }

}