// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"

import PhotoSwipeLightbox from "photoswipe/lightbox"
import PhotoSwipe from "photoswipe"

document.addEventListener('turbo:load', () => {
  // lightGallery(document.getElementById('lightgallery'), {
  //   licenseKey: '0000-0000-000-0000',
  //   speed: 500,
  // });
  const lightbox = new PhotoSwipeLightbox({
    gallery: '#gallery',
    children: 'a.gallery-image',
    pswpModule: () => PhotoSwipe
  });
  lightbox.init();
})

window.initMap = function (...args) {
  const event = new Event('google-maps-callback', {
    bubbles: true, cancelable: true, ...args
  })
  window.dispatchEvent(event)
}

