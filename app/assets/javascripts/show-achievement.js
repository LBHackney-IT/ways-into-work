$.fn.showAchievement = function() {
  
  if (this.length === 0) { return false; }
  
  $(this).click(function() {
    var id = $(this).data('target-id');
    var target = $('#achievement_' + id);
    target.removeClass('is-hidden');
  })
  
}
