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


var $fileInput = $('.file_input');
var $droparea = $('.file_droparea');

$fileInput.on('dragenter focus click', function () {
  $droparea.addClass('is-active');
});

$fileInput.on('dragleave blur drop', function () {
  $droparea.removeClass('is-active');
});

$fileInput.on('change', function () {
  var filesCount = $(this)[0].files.length;
  var $textContainer = $(this).prev('.js-set-number');
  if (filesCount === 1) {
    $textContainer.text($(this).val().split('\\').pop());
  } else {
    $textContainer.text(filesCount + ' uploaded files');
  }
});


function callbackOnOpen1() {
  console.log(data);
}
