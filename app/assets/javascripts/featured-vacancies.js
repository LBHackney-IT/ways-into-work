var placeVacancy = function(source, destination) {
  var sourceData = source.data();
  var destinationData = destination.data();
  
  $.post(destinationData.url, {
    _method:'PUT',
    featured_vacancy: { vacancy_id: sourceData.id }
  }, function() {
    destination.find('.job_title').html(sourceData.title);
    destination.find('.vacancy_type').html(sourceData.vacancyType);
    destination.find('.salary').html(sourceData.salary);
    destination.find('.job_description').html(sourceData.description);
    
    $(source).addClass('is-hidden');
    $(source).addClass('is-hidden');
    $('tr#vacancy_'+ destinationData.vacancyId).removeClass('is-hidden');
    
    destination.data('vacancyId', sourceData.id);
  });
}

$.fn.featuredVacancies = function() {

  if (this.length === 0) { return false; }
  
  $(this).find('tr').draggable({
    helper: 'clone',
  });
  
  $(this).find('.featured-vacancy').droppable({
      drop: function (event, ui) {
        placeVacancy(ui.draggable, $(this))
      }
  });
  
}
