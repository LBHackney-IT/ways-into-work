$.fn.removeAdvisors = function() {

  if (this.length === 0) { return false; }
  
  var id = $(this).val();
  var hideAdvisors = function(id) {
    $('#advisor option').removeClass('is-hidden');
    if (id == "") { return false; }
    $('#advisor option[data-hub-id][data-hub-id!='+ id +']').addClass('is-hidden');
  }
  
  hideAdvisors(id);
  
  $(this).change(function() {
    $('#advisor').val('');
    hideAdvisors($(this).val());
  });

};
