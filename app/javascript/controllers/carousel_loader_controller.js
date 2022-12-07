import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    $('.card_carousel').owlCarousel({
      loop: false,
      margin: 0,
      items: 1,
      autoplay: false,
      nav: false,
      dots: true,
    });
  }
}