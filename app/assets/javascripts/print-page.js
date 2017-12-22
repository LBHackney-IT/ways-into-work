$.fn.afterprint = function(callback) {
  return $(this).each(function() {
    if ( this.onafterprint !== undefined ) {
      $(this).on('afterprint', callback);
    } else if (matchMedia) {
      var mediaQueryList = this.matchMedia('print');
      mediaQueryList.addListener(function(mql) {
        if (!mql.matches) callback();
      });
    }
  });
};

$.fn.printPage = function() {

  if (this.length === 0) { return false; }
  
  var closePrint = function() {
    $('#print_window').remove();
  }
  
  $(this).on('click', function() {
    var printFrame = $('<iframe />')
                      .attr('style', 'visibility: hidden; position: fixed; bottom: 0; right: 0')
                      .attr('src', $(this).attr('href'))
                      .attr('id', 'print_window');
                      
    printFrame.on('load', function() {
      this.contentWindow.onbeforeunload = closePrint;
      $(this.contentWindow).afterprint(closePrint);
      this.contentWindow.focus(); // Required for IE
      this.contentWindow.print();
    })
    
    printFrame.appendTo('body');
    
    return false;
  });
  
}
