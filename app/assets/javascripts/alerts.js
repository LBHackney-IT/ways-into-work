$.fn.alerts = function(timeOut) {
  if (this.length === 0) { return false; }

  if (timeOut != 0) {
    timeOut = timeOut || 5000;
    setTimeout(function() {
      $('#alerts').slideUp();
    }, timeOut);
  }

  $('#alert_close').click(function() {
    $('#alerts').slideUp();
  });
};
