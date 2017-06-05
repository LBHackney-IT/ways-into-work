$.fn.handleFormElements = function() {

  if (this.length === 0) { return false; }

  toggleOther = $(this).find('#toggle_other')

  convertCheckbox = $(this).find('.convert_checkbox')

  convertRadio = $(this).find('.convert_radio')


  if(convertCheckbox.length) {
    convertCheckbox.find('input[type=checkbox]').each(function() {
      if ($(this).is(':checked')) {
        $(this).parents('.checkbox label').addClass('is-primary is-outlined');
      }
    });
    convertCheckbox.find('input[type=checkbox]').click(function() {
      if ($(this).parents('.convert_checkbox').hasClass('single_option')) {
        currentClick = $(this)
        $('.convert_checkbox input[type=checkbox]').each(function() {
          if ($(this).is(':checked')) {
            $(this).not(currentClick).attr('checked', false).parents('.checkbox label').removeClass('is-primary is-outlined');
          }
        });
      }
      $(this).parents('.checkbox label').toggleClass('is-primary is-outlined');
    });
  }

  if(toggleOther.length) {
    textFieldBlock = toggleOther.parents('#other').find('#other_text');

    if (textFieldBlock.find('input[type=text]').val() != '') {
      toggleOther.parents('.checkbox label').addClass('is-primary is-outlined');
      textFieldBlock.removeClass('is-hidden');
    }

    toggleOther.change(function() {
      textFieldBlock.toggleClass('is-hidden');
      if(textFieldBlock.hasClass('is-hidden')) {
        textFieldBlock.find('input[type="text"]').val('');
      } else {
        textFieldBlock.find('input[type="text"]').focus();
      }
    });
  }

  if (convertRadio.length) {
    // add style classes to convert the radio buttons

    convertRadio.find('input[type=radio]').change(function() {
      $(this).parents('.convert_radio').find('.is-primary').removeClass('is-primary is-outlined');
      $(this).parents('.radio label').addClass('is-primary is-outlined');
      if ($(this).val() == 'true') {
        $('.on-true').removeClass('is-hidden');
        $('.on-false').addClass('is-hidden').find('input').clearAllInputs();
      } else {
        $('.on-false').removeClass('is-hidden');
        $('.on-true').addClass('is-hidden').find('input').clearAllInputs();
      }
    });

    $.fn.clearAllInputs = function() {
      $(this).each(function() {
        switch(this.type) {
        case 'password':
        case 'text':
        case 'textarea':
        case 'file':
        case 'select-one':
        case 'select-multiple':
        case 'date':
        case 'number':
        case 'tel':
        case 'email':
          jQuery(this).val('');
          break;
        case 'checkbox':
        case 'radio':
          this.checked = false;
          $(this).parents('.checkbox label').removeClass('is-primary is-outlined');
          break;
        }
      });
    };
  }
};
