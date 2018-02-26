$.fn.updateAdvisors = function() {
  
  if (this.length === 0) { return false; }
  
  var hideAdvisors = function(hubID) {
    $('#filterrific_by_advisor_id option').prop('disabled', false);
    if (hubID) {
      $('#filterrific_by_advisor_id option[data-hub-id!="'+ hubID +'"]').prop('disabled', true);
    }
  }
  
  $(this).on('change', function() {
    var hubID = $(this).val();
    hideAdvisors(hubID);
  });
  
  hideAdvisors($(this).val());
}
