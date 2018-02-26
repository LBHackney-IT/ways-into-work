$.fn.filterrificBrowserHistory = function() {

  if (this.length === 0) { return false; }

  $('body').on('filterrific_filter:submit', null, null, function(e){
    if ($('body').data('run-event') !== false) {
      history.pushState(null, '', "?" + $("#filterrific_filter").serialize());
    }
  });

  $(window).on('popstate', function() {
    var $element;
    $('body').data('run-event', false);
    Filterrific.init();
    if (window.location.search == '') {
      window.location.reload()
    } else {
      var params = window.location.search.substring(1).split('&').reduce(function (params, param) {
          var paramSplit = param.split('=').map(function (value) {
              return decodeURIComponent(value.replace('+', ' '));
          });
          params[paramSplit[0]] = paramSplit[1];
          return params;
      }, {});
      $.each(params, function(k,v) {
        $element = $('[name="'+ k +'"]');
        $element.val(v);
        $element.trigger('change')
      })
    }
    $('body').data('run-event', true);
  })
  
};
