$.fn.handleFormElements = function() {

  if (this.length === 0) { return false; }

  toggleOther = $(this).find('#toggle_other')

  convertCheckbox = $(this).find('.convert_checkbox')

  if(convertCheckbox.length)
    convertCheckbox.find('input[type=checkbox]').each(function() {
      if ($(this).is(':checked')) {
        $(this).parents('.checkbox').addClass('is-primary is-outlined');
      }
    });
    convertCheckbox.find('input[type=checkbox]').click(function() {
      $(this).parents('.checkbox').toggleClass('is-primary is-outlined');
    });

  if(toggleOther.length)
    textFieldBlock = toggleOther.parents('#other').find('#other_text');
    console.log(textFieldBlock.find('input[type=text]').val());
    if (textFieldBlock.find('input[type=text]').val() != '') {
      toggleOther.parents('.checkbox').addClass('is-primary is-outlined');
      textFieldBlock.removeClass('is-hidden');
    }

    toggleOther.change(function() {
      textFieldBlock.toggleClass('is-hidden');
      if(textFieldBlock.hasClass('is-hidden')) {
        textFieldBlock.find('input[type="text"]').val('');
      }
    });

};
