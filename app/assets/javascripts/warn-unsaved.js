$.fn.warnUnsaved = function() {
  if (this.length === 0) { return false; }
  
  var unsaved = false;
  var inputs = $(this).find(':input');
  
  inputs.change(function() {
    unsaved = true;
  });
  
  $(this).on('submit', function() {
    unsaved = false;
  })
  
  $(window).bind('beforeunload', function() {
    if (unsaved) {
      return 'You have unsaved changes. Do you want to leave this page and discard your changes or stay on this page?';
    }
  });
}
