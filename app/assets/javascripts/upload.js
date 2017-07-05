$.fn.uploadFile = function() {

  if (this.length === 0) { return false; }
  $form = $(this)
  $input  = $('#file_upload_attachment')
  $submit = $('#submit_file')

  $input.change(function() {
    if($(this).val().length) {
      $submit.removeAttr('disabled')
    } else {
      $submit.attr('disabled', true)
    }
  });

  $form.on('submit', function(){
    $submit.attr('disabled', true)
  });
};
