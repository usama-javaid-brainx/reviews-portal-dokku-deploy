import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["reviewDetails"]

  connect() {
    this.reviewLocations = [];
    for (let i = 0; i < this.reviewDetailsTargets.length; i++) {
      let reviewLocation = {id: this.reviewDetailsTargets[i].getAttribute('id')};
      reviewLocation["name"] = this.reviewDetailsTargets[i].getAttribute('data-name')
      reviewLocation["longitude"] = this.reviewDetailsTargets[i].getAttribute('data-longitude')
      reviewLocation["latitude"] = this.reviewDetailsTargets[i].getAttribute('data-latitude')
      this.reviewLocations.push(reviewLocation)
    }
    this.multiMarker()
  }

  multiMarker() {
    const infoWindow = new google.maps.InfoWindow()
    var bounds = new google.maps.LatLngBounds();
    var map = new google.maps.Map(document.getElementById('reviewMap'), {
      zoom: 3,
      center: new google.maps.LatLng(52.2571543, 20.984522),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    var marker, i;
    for (i = 0; i < this.reviewLocations.length; i++) {
      let latitude = parseFloat(this.reviewLocations[i]["latitude"]);
      let longitude = parseFloat(this.reviewLocations[i]["longitude"]);
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        title: this.reviewLocations[i]["name"],
      });
      bounds.extend(marker.position);
      google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
        return function() {
          infoWindow.setContent(marker.title);
          infoWindow.open(map, marker);
        }
      })(marker, i));
    }
  }
}