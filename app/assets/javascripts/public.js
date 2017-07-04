// var show_ajax_message = function(type, msg) {
//   $("#flash-message").html('<div id="flash_'+type+'">'+msg+'</div>');
// };

// $(function(){
//   $.ajaxSetup({
//     beforeSend: function( xhr ) {
//       var token = $('meta[name="csrf-token"]').attr('content');
//       if (token) xhr.setRequestHeader('X-CSRF-Token', token);
//     }
//   });
// });

$(document).ready(function() {

  $('.nav-toggle').mobileNav();

  // Removing explicit eligibility check to only use postcode
  // May come back
  // $(".legal_pages.eligibility").checkAccepted();

  $('.delete').hideDelete();

  $(".validate").validate();

  $("form").handleFormElements();

  $("#tabs").tabs();

  $("#clients_needing_appointment").clients_needing_appointment();

});
