$.fn.handleFormElements = function() {

  if (this.length === 0) { return false; }

  toggleOther = $(this).find('#toggle_other')

  convertCheckbox = $(this).find('.convert_checkbox')

  if(convertCheckbox.length)
    convertCheckbox.find('input[type=checkbox]').click(function() {
      $(this).parents('.checkbox').toggleClass('is-primary is-outlined');
    });

  if(toggleOther.length)
    textFieldBlock = toggleOther.parents('#other').find('#other_text');

    toggleOther.change(function() {
      textFieldBlock.toggleClass('is-hidden');
      if(textFieldBlock.hasClass('is-hidden')) {
        textFieldBlock.find('input[type="text"]').val('');
      }
    });

};
