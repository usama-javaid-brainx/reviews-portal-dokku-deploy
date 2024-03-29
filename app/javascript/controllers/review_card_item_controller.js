import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

  static values = {
    longitude: String,
    latitude: String,
    name: String
  }

  createMarker(map) {
    this.marker = new google.maps.Marker({
      position: new google.maps.LatLng(parseFloat(this.latitudeValue), parseFloat(this.longitudeValue)),
      map: map,
      title: this.nameValue,
    });
    return this.marker
  }

  mouseEnter(_event) {
    if (typeof this.marker !== "undefined") {
      this.marker.setAnimation(google.maps.Animation.BOUNCE);
    }
  }

  mouseLeave(_event) {
    if (typeof this.marker !== "undefined") {
      this.marker.setAnimation(null);
    }
  }

}