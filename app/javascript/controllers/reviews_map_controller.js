import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mapDisplay"]

  connect() {
    if (localStorage.getItem("map") == "on") {
      this.filterController.forEach(controller => {
        controller.showMap()
      })
    }
  }

  initilizeMap() {
    for (let i = 0; i < this.mapDisplayTargets.length; i++) {
      let bounds = new google.maps.LatLngBounds();
      let map = new google.maps.Map(this.mapDisplayTargets[i], {
        zoom: 5,
        center: new google.maps.LatLng(0, 0),
      });
      this.reviewCardItemControllers.forEach(controller => {
        let marker = controller.createMarker(map)
        this.infoPopups(marker, map)
        if (!(isNaN(marker.position.lat()) && isNaN(marker.position.lng()))) {
          bounds.extend(marker.position);
        }
      })
      map.fitBounds(bounds)
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

  get filterController() {
    return this.application.controllers.filter(controller => {
      return controller.context.identifier === 'filter'
    })
  }

}
