$.fn.clients_needing_appointment = function() {

  if (this.length === 0) { return false; }

  $("#clients_needing_appointment").click(function() {
    if ($("#clients_needing_appointment").hasClass('open')) {
      console.log('test1')
      $("#clients_needing_appointment #hidden-section").slideUp();
    } else {
      $("#clients_needing_appointment #hidden-section").slideDown();
      console.log('test2')
    }

    $("#clients_needing_appointment").toggleClass('open');
  });

};
