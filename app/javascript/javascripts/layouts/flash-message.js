document.addEventListener('turbolinks:load', function() {
  setTimeout("$('.alert-success').fadeOut('slow')", 3000);
})