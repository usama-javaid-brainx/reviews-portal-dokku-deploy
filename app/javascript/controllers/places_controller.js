import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "map", "name", "placeId", "latitude", "longitude", "address", "city", "state", "country"]

  connect() {
    if (typeof (google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    this.postion = new google.maps.LatLng(this.latitude, this.longitude)
    this.map = new google.maps.Map(this.mapTarget, {
      center: this.postion,
      zoom: (this.latitude == null ? 4 : 15)
    })
    // The marker, positioned at Uluru
    const marker = new google.maps.Marker({
      position: this.postion,
      map: this.map,
    });

    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['place_id', 'address_components', 'geometry', 'icon', 'name'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))

    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, -29)
    })
  }

  placeChanged() {
    let place = this.autocomplete.getPlace()

    if (!place.geometry) {
      window.alert(`No details available for input: ${place.name}`)
      return
    }

    if (place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport)
    } else {
      this.map.setCenter(place.geometry.location)
      this.map.setZoom(17)
    }

    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)
    debugger
    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
    this.nameTarget.value = place.name
    this.placeIdTarget.value = place.place_id

    let address1 = "";
    let postcode = "";

    // Get each component of the address from the place details,
    // and then fill-in the corresponding field on the form.
    // place.address_components are google.maps.GeocoderAddressComponent objects
    // which are documented at http://goo.gle/3l5i5Mr
    for (const component of place.address_components) {
      // @ts-ignore remove once typings fixed
      const componentType = component.types[0];

      switch (componentType) {
        case "street_number": {
          address1 = `${component.long_name} ${address1}`;
          break;
        }

        case "route": {
          address1 += component.short_name;
          break;
        }

        case "postal_code": {
          postcode = `${component.long_name}${postcode}`;
          break;
        }

        case "postal_code_suffix": {
          postcode = `${postcode}-${component.long_name}`;
          break;
        }
        case "locality":
          this.cityTarget.value = component.long_name;
          break;
        case "administrative_area_level_1": {
          this.stateTarget.value = component.short_name;
          // console.log(component.short_name)
          break;
        }
        case "country":
          this.countryTarget.value = component.long_name;
          break;
      }
    }

    this.addressTarget.value = `${address1} ${postcode}`;
  }

  keydown(event) {
    if (event.key === "Enter") {
      event.preventDefault()
    }
  }

  get latitude() {
    return this.data.get('latitude') || this.latitudeTarget.value || 40.712775
  }

  get longitude() {
    return this.data.get('longitude') || this.longitudeTarget.value || -74.005973
  }
}
