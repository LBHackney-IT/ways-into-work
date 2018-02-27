$.fn.parralax = function(speed = 0.2, reverse = false) {
  if (this.length === 0) { return false; }

  const ele = document.getElementById(this.attr('id'));

  ele.style.transform = 'translateY( calc( var(--scrollparallax) * 1px ) )';

  function setScrollParallax() {
      var offset = (document.body.scrollTop || document.documentElement.scrollTop) * speed
      if (reverse) {
        offset = offset*-1;
      }
      ele.style.setProperty("--scrollparallax", offset);
      window.requestAnimationFrame( setScrollParallax );
  }

  window.requestAnimationFrame( setScrollParallax );
};
