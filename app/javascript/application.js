// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import PhotoSwipeLightbox from "photoswipe-lightbox"
import PhotoSwipe from "photoswipe"

document.addEventListener('turbo:load', () => {
  // lightGallery(document.getElementById('lightgallery'), {
  //   licenseKey: '0000-0000-000-0000',
  //   speed: 500,
  // });
  const lightbox = new PhotoSwipeLightbox({
    gallery: '#lightgallery',
    children: 'a',
    pswpModule: () => PhotoSwipe
  });
  lightbox.init();
})