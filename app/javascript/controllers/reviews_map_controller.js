import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static target = ["mapDisplay"]

  connect() {
    this.initMap()
  }

  initMap() {
    const infoWindow = new google.maps.InfoWindow()
    let bounds = new google.maps.LatLngBounds();
    let map = new google.maps.Map(document.getElementById('reviewMap'), {
      zoom: 5,
      center: new google.maps.LatLng(52.2571543, 20.984522),
    });

    this.reviewCardItemControllers.map((controller) => {
        let marker = controller.createMarker(map)
        if (this.marker !== null) {
          bounds.extend(marker.position);
        }
      }
    )
  }

  get reviewCardItemControllers() {
    return this.application.controllers.filter(controller => {
      return controller.context.identifier === 'review-card-item'
    })
  }
}
