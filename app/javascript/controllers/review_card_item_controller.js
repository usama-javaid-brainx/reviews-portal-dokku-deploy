import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["reviewCardDetails"]

  creatMarker() {
    var marker, i;
    for (i = 0; i < this.reviewLocations.length; i++) {
      let latitude = parseFloat(this.reviewLocations[i]["latitude"]);
      let longitude = parseFloat(this.reviewLocations[i]["longitude"]);
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        title: this.reviewLocations[i]["name"],
      });
    }
  }
}