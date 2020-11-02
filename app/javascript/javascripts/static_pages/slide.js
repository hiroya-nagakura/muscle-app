if (window.matchMedia('(max-width: 768px)').matches) {
  document.addEventListener('turbolinks:load', function() {
    $('.slide').slick({
      dots: true,
      autoplay: true,
      autoplaySpeed: 5000,
      slidesToShow: 2,
      slidesToScroll: 2,
      responsive: [
        {
          breakpoint: 450,
          settings: {
            slidesToShow: 1,
            slidesToScroll: 1,
          }
        },
      ]
    });
  });
};