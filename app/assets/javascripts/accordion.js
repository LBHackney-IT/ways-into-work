$.fn.accordion = function() {
  if (this.length === 0) { return false; }

  /*
    A few things that would be nice to add to this
    - there could be a pre built in fa-chevron-down or some form of icon to indicate it can be opened, which when clicked could be animated with CSS to rotate to the upwards direction.
    - Customised features:
      - May want to cusomtise the speed of the slide toggle (if slower then what happens if one is clicked while the other is animating?)
      - May want the ability to choose between multiple independant accodrions or all accordions interacting on a page for sites with more than one.
    - anything else?
  */

  var parentAccord = $(this)

  parentAccord.find('.accord-toggle').click(function(){
    $(this).next().slideToggle('fast');
    var currentContainer = $(this).closest('.accord-single');
    currentContainer.toggleClass('open');

    $(this).closest('.accordion').find('.accord-single.open').not(currentContainer).removeClass('open');
    parentAccord.find('.accord-cont').not($(this).next()).slideUp('fast');

  });
};
