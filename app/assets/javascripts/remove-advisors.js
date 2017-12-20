$.fn.removeAdvisors = function() {

  if (this.length === 0) { return false; }
  
  $(this).change(function() {
    $('#advisor option').removeClass('is-hidden');
    var id = $(this).val()
    if (id == "") { return false; }
    $('#advisor option[data-hub-id][data-hub-id!='+ id +']').addClass('is-hidden');
  });

};
