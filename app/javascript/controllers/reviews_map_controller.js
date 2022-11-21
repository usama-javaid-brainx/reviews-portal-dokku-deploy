import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mapDisplay"]

  connect() {
    this.initMap()
  }

  initMap() {
    let bounds = new google.maps.LatLngBounds();
    let map = new google.maps.Map(this.mapDisplayTarget, {
      zoom: 3,
      center: new google.maps.LatLng(52.2571543, 20.984522),
    });

    this.reviewCardItemControllers.forEach(controller => {
        let marker = controller.createMarker(map)
        var infoWindow = new google.maps.InfoWindow();
        google.maps.event.addListener(marker, 'click', function () {
          infoWindow.setContent(marker.title);
          infoWindow.open(map, this);
        });
        bounds.extend(marker.position);
      }
    )
  }

  get reviewCardItemControllers() {
    return this.application.controllers.filter(controller => {
      return controller.context.identifier === 'review-card-item'
    })
  }
}
