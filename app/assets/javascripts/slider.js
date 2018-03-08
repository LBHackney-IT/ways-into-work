$.fn.slider = function() {
  if (this.length === 0) { return false; }
  var inUse = false;

  $('.testimonial.clickable').click(function() {
    if($(this).hasClass('active') && inUse == false) {
      var num = $(this).data('number');
      if (num == 3) {
        num = 1;
      } else {
        num++
      }
      animateSlider(num);
    }
  });

  $('.indicator').click(function() {
    if(!$(this).hasClass('active') && inUse == false) {
      animateSlider($(this).data('number'));
    }
  });

  function animateSlider(number) {
    inUse = true;
    $('.testimonial.active').fadeOut(function() {
      $('.slider .active').removeClass('active');
      $('#testimonial'+number).fadeIn(function() {
        $(this).addClass('active');
        inUse = false;
      });
      $('#indi'+number).addClass('active');
    });
  }

};
