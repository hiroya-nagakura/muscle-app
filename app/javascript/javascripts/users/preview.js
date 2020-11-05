document.addEventListener('turbolinks:load', function() {
  const file_image = document.getElementById('prof-file')
  if (file_image){
    file_image.addEventListener('change', function (e) {
      const file = e.target.files[0];
      const fileReader = new FileReader();
      fileReader.onload = function() {
        const img = document.getElementById('img-preview');
        img.src = this.result;
      };
      fileReader.readAsDataURL(file);
    });
  }
})