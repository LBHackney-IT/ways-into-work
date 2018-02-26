$.fn.removeAdvisors = function(target) {

  if (this.length === 0) { return false; }
  
  var id = $(this).val();
  var hideAdvisors = function(id) {
    $(target + ' option').removeClass('is-hidden');
    if (id == "") { return false; }
    $(target + ' option[data-hub-id][data-hub-id!='+ id +']').addClass('is-hidden');
  }
  
  hideAdvisors(id);
  
  $(this).change(function() {
    $(target).val('');
    hideAdvisors($(this).val());
  });

};
