$.fn.mobileNav = function() {

  if (this.length === 0) { return false; }

  $(this).click(function() {
    $('.nav-menu').toggleClass('is-active');
  });
};
