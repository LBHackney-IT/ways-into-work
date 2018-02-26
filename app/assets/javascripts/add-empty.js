$.fn.addEmpty = function(timeOut) {
  
  if (this.length === 0) { return false; }
  
  var $form = $(this);
  var $attributes = $('input[type="checkbox"][name^="client"]');
  var addHiddenField = function(name) {
    var checkedBoxes = $('input[name="'+ name +'"]:checked');
    var hiddenField = $('input[name="'+ name +'"][type="hidden"]')
    if (checkedBoxes.length == 0) {
      if (hiddenField.length == 0) {
        $('<input>').attr({
            type: 'hidden',
            value: '',
            name: name
        }).appendTo($form);
      }
    } else {
      hiddenField.remove();
    }
  };
  
  $attributes.each(function() {
    addHiddenField($(this).attr('name'));
  });
  
  $attributes.on('change', function() {
    addHiddenField($(this).attr('name'));
  });
  
}
