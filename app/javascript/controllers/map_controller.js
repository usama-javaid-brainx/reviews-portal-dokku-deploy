import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    latitude: String,
    longitude: String
  }

  openMap() {
    window.open(`https://maps.google.com/?q=${this.latitudeValue},${this.longitudeValue}`, '_blank')
  }
}