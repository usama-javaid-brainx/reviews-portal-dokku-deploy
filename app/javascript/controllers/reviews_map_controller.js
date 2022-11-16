import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["reviewDetails"]

  connect() {
    this.allReviews()
  }

  get reviewCardItemController() {
    return this.application.controllers.filter(controller => {
      return controller.context.identifier === 'review-card-item'
    })
  }

  allReviews() {
    let allControllers = this.reviewCardItemController
    const infoWindow = new google.maps.InfoWindow()
    let bounds = new google.maps.LatLngBounds();
    let marker, i;
    let map = new google.maps.Map(document.getElementById('reviewMap'), {
      zoom: 3,
      center: new google.maps.LatLng(52.2571543, 20.984522),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    for (i = 0; i < allControllers.length; i++) {
      let latitude = parseFloat(allControllers[i].element.getAttribute('data-latitude'));
      let longitude = parseFloat(allControllers[i].element.getAttribute('data-longitude'));
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        title: allControllers[i].element.getAttribute('data-name'),
      });
      bounds.extend(marker.position);
    }
  }


  // for (let i = 0; i < allControllers.length; i++) {
  //   let reviewLocation = {id: allControllers[i].element.getAttribute('id')}
  //   reviewLocation["name"] = allControllers[i].element.getAttribute('data-name')
  //   reviewLocation["longitude"] = allControllers[i].element.getAttribute('data-longitude')
  //   reviewLocation["latitude"] = allControllers[i].element.getAttribute('data-latitude')
  //   this.allLocations.push(reviewLocation)
  // }


  // multiMarker() {
  // const infoWindow = new google.maps.InfoWindow()
  // var bounds = new google.maps.LatLngBounds();
  // var map = new google.maps.Map(document.getElementById('reviewMap'), {
  //   zoom: 3,
  //   center: new google.maps.LatLng(52.2571543, 20.984522),
  //   mapTypeId: google.maps.MapTypeId.ROADMAP
  // });
  // var marker, i;
  // for (i = 0; i < this.reviewLocations.length; i++) {
  //   let latitude = parseFloat(this.reviewLocations[i]["latitude"]);
  //   let longitude = parseFloat(this.reviewLocations[i]["longitude"]);
  //   marker = new google.maps.Marker({
  //     position: new google.maps.LatLng(latitude, longitude),
  //     map: map,
  //     title: this.reviewLocations[i]["name"],
  //   });
  //   bounds.extend(marker.position);
  // google.maps.event.addListener(marker, 'mouseover', (function (marker, i) {
  //   return function () {
  //     infoWindow.setContent(marker.title);
  //     infoWindow.open(map, marker);
  //   }
  // })(marker, i));
  // }

}
