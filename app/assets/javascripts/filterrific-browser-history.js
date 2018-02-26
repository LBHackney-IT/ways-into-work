$.fn.filterrificBrowserHistory = function() {

  if (this.length === 0) { return false; }

  $('body').on('filterrific_filter:submit', null, null, function(e){
    history.pushState(null, '', "?" + $("#filterrific_filter").serialize());
  });
  
};
