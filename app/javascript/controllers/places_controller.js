import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "map", "name", "placeId", "latitude", "longitude", "address", "city", "state", "country", "reviews", "rating"]
  static values = {
    latitude: String,
    longitude: String,
    placeId: String
  }

  connect() {
    if (typeof (google) != "undefined") {
      this.initMap()

      if (this.hasReviewsTarget) {
        this.fetchPlaceReviews()
      }
    }
  }

  initMap() {
    this.postion = new google.maps.LatLng(this.latitudeValue, this.longitudeValue)
    this.map = new google.maps.Map(this.mapTarget, {
      center: this.postion, zoom: (this.latitudeValue == null ? 4 : 15)
    })
    // The marker, positioned at Uluru
    this.marker = new google.maps.Marker({
      position: this.postion, map: this.map,
    });

    if (this.hasFieldTarget) {
      this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
      this.autocomplete.bindTo('bounds', this.map)
      this.autocomplete.setFields(['place_id', 'address_components', 'geometry', 'icon', 'name'])
      this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))
    }
    // this.marker = new google.maps.Marker({
    //   map: this.map, anchorPoint: new google.maps.Point(0, -29)
    // })
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
    this.latitudeValue = this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeValue = this.longitudeTarget.value = place.geometry.location.lng()
    this.nameTarget.value = place.name
    this.placeIdValue = this.placeIdTarget.value = place.place_id

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

  fetchPlaceReviews() {
    let request = {
      placeId: this.placeIdValue // example: ChIJN1t_tDeuEmsRUsoyG83frY4
    }
    let service = new google.maps.places.PlacesService(this.map) // map is your map object
    service.getDetails(request, this.placeDetailsCallback.bind(this))
  }

  placeDetailsCallback(place, status) {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
      console.log(place)
      this.ratingTarget.innerHTML = place.rating
      let reviews = ''
      place.reviews.forEach((review) => {
        reviews += `<div class="d-flex">
            <div class="left">
                        <span>
                            <img src="${review.profile_photo_url}" class="profile-pict-img img-fluid" alt=""/>
                        </span>
            </div>
            <div class="right">
              <h4>
                ${review.author_name}
                <span class="gig-rating text-body-2">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1792 1792" width="15" height="15">
                                    <path
                                      fill="currentColor"
                                      d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"
                                    ></path>
                                </svg>
                                ${review.rating}
                            </span>
              </h4>
              <div class="review-description">
                <p>
                  ${review.text}
                </p>
              </div>
              <span class="publish py-3 d-inline-block w-100">Published ${review.relative_time_description}</span>
            </div>
          </div>`
      })

      this.reviewsTarget.innerHTML = reviews
    }
  }

  // get placeId() {
  //   return this.data.get('placeId') || this.placeIdTarget.value
  // }

  // get latitude() {
  //   return this.data.get('latitude') || this.latitudeTarget.value || 40.712775
  // }
  //
  // get longitude() {
  //   return this.data.get('longitude') || this.longitudeTarget.value || -74.005973
  // }
}
