$.fn.clickableRow = function() {
  if (this.length === 0) { return false; }

  $(this).click(function() {
    window.location = $(this).data("href");
  });

};
