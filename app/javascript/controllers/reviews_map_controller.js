import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mapDisplay"]

  initilizeMap() {
    for (let i = 0; i < this.mapDisplayTargets.length; i++) {
      let bounds = new google.maps.LatLngBounds();
      let map = new google.maps.Map(this.mapDisplayTargets[i], {
        zoom: 2,
        center: new google.maps.LatLng(0, 0),
      });
      this.reviewCardItemControllers.forEach(controller => {
        debugger
        let marker = controller.createMarker(map)
        bounds.extend(marker.position);
        this.infoPopups(marker, map)
      })
    }
  }

  infoPopups(marker, map) {
    var infoWindow = new google.maps.InfoWindow();
    google.maps.event.addListener(marker, 'click', function () {
      infoWindow.setContent(marker.title);
      infoWindow.open(map, this);
    });
  }

  get reviewCardItemControllers() {
    return this.application.controllers.filter(controller => {
      return controller.context.identifier === 'review-card-item'
    })
  }
}
