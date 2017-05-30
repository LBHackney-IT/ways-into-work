$.fn.handleFormElements = function() {

  if (this.length === 0) { return false; }

  toggleOther = $(this).find('#toggle_other')

  if(toggleOther.length)
    textFieldBlock = toggleOther.siblings('#other_text')

    toggleOther.change(function() {
      textFieldBlock.toggleClass('is-hidden');
      if(textFieldBlock.hasClass('is-hidden')) {
        textFieldBlock.find('input[type="text"]').val('');
      }
    });

};
