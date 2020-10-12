$(document).on('turbolinks:load', function() {
  var btn = document.getElementById('new-bodyweight-btn');
  var bodyweight_modal = document.getElementById('bodyweight-modal');

  if (btn) {
    btn.addEventListener('click', function() {
    bodyweight_modal.style.display = 'block';
    });
  }

  window.addEventListener('click', function(e) {
    if (e.target == bodyweight_modal) {
      bodyweight_modal.style.display = 'none';
    }
  });
});
