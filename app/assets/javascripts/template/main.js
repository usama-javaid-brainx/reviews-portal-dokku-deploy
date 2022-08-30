(function ($) {
    "use strict";
    $(window).on('load', function(){
        // Prealoder
        $("#preloader").delay(1000).fadeOut("slow");
    });

    $(document).ready(function () {

        // card carousel Initialize
        $('.card_carousel').owlCarousel({
            loop: true,
            margin: 0,
            items: 1,
            autoplay: false,
            nav: false,
            dots: true
        });

        // niceSelect Initialize
        $('.middle_nav select').niceSelect();

        // SimpleBar Initialize
        var myElement = document.getElementById('simple-bar');
        new SimpleBar(myElement, { autoHide: true });

    });

    $(document).ready(function(){
        // Smooth Scroll Effect
        $('.add_review_area .nav-pills .nav-link').bind('click', function (event) {
            var $anchor = $(this);
            var headerH = 130;
            $('html, body').stop().animate({
                scrollTop: $($anchor.attr('href')).offset().top - headerH + "px"
            }, 500);
            event.preventDefault();
        });
    })

})(jQuery);

