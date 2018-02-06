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

  // $("#tabs").tabs({
  //     activate: function(event, ui) {
  //         window.location.hash = ui.newPanel.attr('id');
  //     },
  //     fx: { opacity: 'toggle' },
  //     select: function(event, ui) {
  //         $(this).css('height', $(this).height());
  //         $(this).css('overflow', 'hidden');
  //     },
  //     show: function(event, ui) {
  //         $(this).css('height', 'auto');
  //         $(this).css('overflow', 'visible');
  //     }
  // });

  $("#tabs").tabs({
    beforeActivate: function(event, ui) {
        $(this).data('scrollTop', $(window).scrollTop());
    },
    activate: function(event, ui) {
        if (!$(this).data('scrollTop')) {
            jQuery('html').css('height', 'auto');
            window.location.hash = ui.newPanel.attr('id');
        }

        if ($(window).scrollTop() == $(this).data('scrollTop'))
            window.location.hash = ui.newPanel.attr('id');
        var min_height = $(this).data('scrollTop') + $(window).height();
        if ($('html').outerHeight() < min_height) {
            $('html').height(min_height -
                 ($('html').outerHeight() - $('html').height()));
            window.location.hash = ui.newPanel.attr('id');
        }
        $(window).scrollTop($(this).data('scrollTop'));
    }
});

  $("#new_file_upload").uploadFile();

  $("#clients_needing_appointment").clients_needing_appointment();

  $('#hubs').handleMaps();

  $('#print_page').printPage();

  $('#dashboard_hubs').removeAdvisors();

  $('#referrer_organisation').showOthers();

  $('.show_achievement').showAchievement();

});
