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

  $('#alerts').alerts();

  $(".validate").validate();

  $("form").handleFormElements();

  $("form[method=post]").warnUnsaved();

  $("#tabs").tabs();

  $("#new_file_upload").uploadFile();

  $("#clients_needing_appointment").clients_needing_appointment();

  $('#hubs').handleMaps();

  $('#print_page').printPage();

  $('#dashboard_hubs').removeAdvisors();

  $('#referrer_organisation').showOthers();

  $('.show_achievement').showAchievement();

});
