import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["allReviews", "listView", "gridView", "gridReviewCard", "listReviewCard", "mapView"]

  connect() {
    if (this.navsViewController != undefined) {
      if (localStorage.getItem("view") == "grid" || localStorage.getItem("view") == "") {
        this.gridView()
      } else {
        this.listView()
      }
    }
  }

  gridView() {
    this.navsViewController.navGridTarget.classList.add("active")
    this.navsViewController.navListTarget.classList.remove("active")
    this.gridViewTarget.classList.add("active")
    this.listViewTarget.classList.remove("active")
  }

  listView() {
    this.navsViewController.navGridTarget.classList.remove("active")
    this.navsViewController.navListTarget.classList.add("active")
    this.gridViewTarget.classList.remove("active")
    this.listViewTarget.classList.add("active")
  }

  get navsViewController() {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === 'navs-view'
    })
  }

}