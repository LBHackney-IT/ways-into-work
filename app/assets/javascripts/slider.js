$.fn.slider = function() {
  if (this.length === 0) { return false; }
  var inUse = false;
  $('.indicator').click(function() {
    var indicator = $(this)
    if(!indicator.hasClass('active') && inUse == false) {
      inUse = true;
      var number = indicator.data('number');
      $('.testimonial.active').fadeOut(function() {
        $('.slider .active').removeClass('active');
        $('#testimonial'+number).fadeIn(function() { $(this).addClass('active'); inUse = false });
        indicator.addClass('active');
      });
    }
  });
};
