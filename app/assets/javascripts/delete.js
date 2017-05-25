$.fn.hideDelete = function() {

  if (this.length === 0) { return false; }

  $(this).click(function() {
    $(this).parent().slideUp();
  });

};
