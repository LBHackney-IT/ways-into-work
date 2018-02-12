$.fn.suggestNames = function() {

  if (this.length === 0) { return false; }

  $names = $("#action_plan_task_title")

  $names.autocomplete({
    minLength: 0,
    disabled: false,
    source: function( request, response ) {
      $.ajax( {
        url: "/advisor/task_names",
        data: {
          term: request.term
        },
        success: function( data ) {
          response( data );
        }
      } );
    },
    select: function( event, ui ) {
      $names.val(ui.item.value)
    }
  } ).focus(function () {
    if ($(this).attr('state') != 'open' && $(this).val() == '') {
      $(this).autocomplete("search");
    }
  });

}
