document.addEventListener('turbolinks:load', function() {
  var file_image = document.getElementById('prof-file')
  if (file_image){
    file_image.addEventListener('change', function (e) {
      var file = e.target.files[0];
      var fileReader = new FileReader();
      fileReader.onload = function() {
        var img = document.getElementById('img-preview');
        img.src = this.result;
      };
      fileReader.readAsDataURL(file);
    });
  }
})