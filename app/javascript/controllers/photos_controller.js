import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainThumbnail"]

  updatePhoto() {
    this.mainThumbnailTarget.src = event.currentTarget.src
  }
}