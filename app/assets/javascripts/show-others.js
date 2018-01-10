$.fn.showOthers = function() {
  
  if (this.length === 0) { return false; }
  
  $(this).change(function() {
    if ($(this).val() == 'other') {
      $('span.other-organisation').removeClass('is-hidden')
      $('.other-organisation #referrer_organisation_other').attr('disabled', false)
      $('span.organisation.select').addClass('is-hidden')
      $(this).attr('disabled', true)
    }
  })
  
}
