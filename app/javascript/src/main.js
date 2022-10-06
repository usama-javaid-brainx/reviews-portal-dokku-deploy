import './owcarousal'
import './nice-select'
import './easing.min'
import Lightbox from 'bs5-lightbox';

(function ($) {
  "use strict";
  $(window).on('load', function () {
    // Prealoder
    $("#preloader").delay(1000).fadeOut("slow");
  });

  $(document).on('turbo:load', function () {

    document.querySelectorAll('[data-toggle=lightbox]').forEach(el => el.addEventListener('click', Lightbox.initialize));

    // card carousel Initialize
    $('.card_carousel').owlCarousel({
      loop: false,
      margin: 0,
      items: 1,
      autoplay: false,
      nav: false,
      dots: true,
    });

    // niceSelect Initialize
    $('.middle_nav select').niceSelect();

    // Smooth Scroll Effect
    $('.add_review_area .nav-pills .nav-link').bind('click', function (event) {
      var $anchor = $(this);
      var headerH = 130;
      $('html, body').stop().animate({
        scrollTop: $($anchor.attr('href')).offset().top - headerH + "px"
      }, 500);
      event.preventDefault();
    });
  });

})(jQuery);

