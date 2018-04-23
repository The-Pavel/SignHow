$(document).ready(function() {
  console.log("reading jquery function");
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      // console.log("jquery started");

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#avatar-upload").change(function(){
    $('#img_prev').removeClass('hidden');
    readURL(this);
  });
});
