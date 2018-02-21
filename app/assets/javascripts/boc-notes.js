$.fn.showBocNotes = function() {
  
  if (this.length === 0) { return false; }
  
  $(this).click(function() {
    $('#boc-wrapper').removeClass('is-hidden')
  })
  
}

$.fn.hideBocNotes = function() {
  
  if (this.length === 0) { return false; }
  
  $(this).click(function() {
    $('#boc-wrapper').addClass('is-hidden')
  })
  
}
