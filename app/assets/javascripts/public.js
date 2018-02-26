// var show_ajax_message = function(type, msg) {
//   $("#flash-message").html('<div id="flash_'+type+'">'+msg+'</div>');
// };

$(function(){
  $.ajaxSetup({
    beforeSend: function( xhr ) {
      var token = $('meta[name="csrf-token"]').attr('content');
      if (token) xhr.setRequestHeader('X-CSRF-Token', token);
    }
  });
});

$(document).ready(function() {

  $('.nav-toggle').mobileNav();

  $('#alerts').alerts();

  $('#parralax_me').parralax(0.3, true);
  $('#testimonials .parralax_me').parralax(0.25, true);

  $('#testimonials .slider').slider();

  $(".validate").validate();

  $("form").handleFormElements();

  $("form[method=post]").warnUnsaved();

  $(".clickable_row").clickableRow();

  $(".admin.action_plan_tasks form").suggestNames();

  $('#client_welfare_calculation_completed_true').showBocNotes();

  $('#client_welfare_calculation_completed_false').hideBocNotes();

  $("#tabs").tabs({
    create: function(event, ui) {
      var tabID = $(this).data('activeTab') ;
      var activeTab = document.getElementById(tabID);
      var index = $('#tab-container .tab').index(activeTab);

      $(this).tabs( "option", "active", index );
    },
    beforeActivate: function(event, ui) {
        $(this).data('scrollTop', $(window).scrollTop());
    },
    activate: function(event, ui) {
        var baseUrl = $(this).data('baseUrl');
        if (!$(this).data('scrollTop')) {
            jQuery('html').css('height', 'auto');
            hash = ui.newPanel.attr('id');
        }

        if ($(window).scrollTop() == $(this).data('scrollTop'))
            hash = ui.newPanel.attr('id');
        var min_height = $(this).data('scrollTop') + $(window).height();
        if ($('html').outerHeight() < min_height) {
            $('html').height(min_height -
                 ($('html').outerHeight() - $('html').height()));
            hash = ui.newPanel.attr('id');
        }

        history.pushState({}, $('title').text(), baseUrl + '/' + hash)
        $(window).scrollTop($(this).data('scrollTop'));
    }
  });

  $("#new_file_upload").uploadFile();

  $("#clients_needing_appointment").clients_needing_appointment();

  $('#hubs').handleMaps();

  $('#print_page').printPage();

  $('#dashboard_hubs').removeAdvisors('#advisor');

  $('#referrer_organisation').showOthers();

  $('.show_achievement').showAchievement();

  $('.edit_client').addEmpty();
  
  $('.admin.vacancies.index').featuredVacancies();

  $('#subscribe.button').click(function(){
    window.open('https://public.govdelivery.com/accounts/UKHACKNEYCOUNCIL/subscribers/qualify?email='+$('#newsletter_email').val(), '_blank');
  });
  
  $('#filterrific_filter').filterrificBrowserHistory();
  
  $('#filterrific_by_hub_id').removeAdvisors('#filterrific_by_advisor_id');

});
