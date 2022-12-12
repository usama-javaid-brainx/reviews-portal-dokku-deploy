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

    // Smooth Scroll Effect
    $('.add_review_area .nav-pills .nav-link').bind('click', function (event) {
      var $anchor = $(this);
      var headerH = 130;
      $('html, body').stop().animate({
        scrollTop: $($anchor.attr('href')).offset().top - headerH + "px"
      }, 500);
      event.preventDefault();
    });

      document.querySelectorAll( 'oembed[url]' ).forEach( element => {
      // Create the <a href="..." class="embedly-card"></a> element that Embedly uses
      // to discover the media.
      const anchor = document.createElement( 'a' );

      anchor.setAttribute( 'href', element.getAttribute( 'url' ) );
      anchor.className = 'embedly-card';

      element.appendChild( anchor );
    } );

  });

})(jQuery);

