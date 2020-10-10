if (window.matchMedia('(max-width: 768px)').matches) {
  $(document).on('turbolinks:load', function() {
    $('.slide').slick({
      dots: true,
      autoplay: true,
      autoplaySpeed: 5000,
      slidesToShow: 2,
      responsive: [
        {
          breakpoint: 450,
          settings: {
            slidesToShow: 1
          }
        },
      ]
    });
  });
} 