$.fn.suggestNames = function() {

  if (this.length === 0) { return false; }

  $names = $("#action_plan_task_title")

  $names.autocomplete({
    minLength: 0,
    disabled: false,
    source: function( request, response ) {
      $.ajax( {
        url: "/advisor/task_titles",
        data: {
          term: request.term
        },
        success: function( data ) {
          response( data );
        }
      } );
    },
    select: function( event, ui ) {
      $('.is_shown').addClass('is-hidden').removeClass('is_shown');

      var acheiveId = ui.item.value.replace(/\s+/g, '_').toLowerCase()
      $("." + acheiveId).removeClass('is-hidden').addClass('is_shown');
      $names.val(ui.item.value);
    },
    change: function( event, ui ) {
      if(ui.item == null) {
        $('.is_shown').addClass('is-hidden').removeClass('is_shown');
      }
    }
  } ).focus(function () {
    if ($(this).attr('state') != 'open' && $(this).val() == '') {
      $(this).autocomplete("search");
    }
  });

}
