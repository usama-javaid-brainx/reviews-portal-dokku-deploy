import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainImage"]

  clickImage(event){
    this.mainImageTarget.src = event.currentTarget.src
  }
}