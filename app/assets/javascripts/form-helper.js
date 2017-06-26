$.fn.handleFormElements = function() {

  if (this.length === 0) { return false; }

  convertCheckbox = $(this).find('.convert_checkbox')

  if(convertCheckbox.length) {
    convertCheckbox.find('input[type=checkbox]').each(function() {
      if ($(this).is(':checked')) {
        $(this).parents('.checkbox label').addClass('is-primary is-outlined');
      }
    });
    convertCheckbox.find('input[type=checkbox]').click(function() {
      $(this).parents('.checkbox label').toggleClass('is-primary is-outlined');
    });
  }


  toggleOther = $(this).find('.other')

  if(toggleOther.length) {

    toggleOther.each(function(index, elem) {

      var textFieldBlock = $(elem).find('.other_text');

      if (textFieldBlock.find('input[type=text]').val() != '') {
        $(elem).find('.checkbox label').addClass('is-primary is-outlined');
        textFieldBlock.removeClass('is-hidden');
      }

      $(elem).find('.toggle_other').change(function() {
        textFieldBlock.toggleClass('is-hidden');
        if(textFieldBlock.hasClass('is-hidden')) {
          textFieldBlock.find('input[type="text"]').val('');
        } else {
          textFieldBlock.find('input[type="text"]').focus();
          if( $(elem).parents('.convert_radio').length){
            clearRadioInputs($(elem).parents('.convert_radio').find('input[type=radio]'))
          }
        }
      });
    });
  }

  convertRadio = $(this).find('.convert_radio')

  if (convertRadio.length) {
    convertRadio.find('input[type=radio]').each(function(index, elem) {
      if ($(elem).is(':checked')) {
        $(elem).parents('.radio label').addClass('is-primary is-outlined');
        if(!$(elem).parents('.convert_radio').hasClass('radio_child')) {
          runThroughRadios($(elem));
        }
      }
    });
    convertRadio.find('input[type=radio]').change(function() {

      $(this).parents('.convert_radio').find('.is-primary').removeClass('is-primary is-outlined');
      $(this).parents('.radio label').addClass('is-primary is-outlined');

      clear_other_option($(this))

      if(!$(this).parents('.convert_radio').hasClass('radio_child')) {
        runThroughRadios($(this));
      }
    });

    function clear_other_option(radio_button) {
      other_option =  $(radio_button).parents('.convert_radio').find('.other')
      if(other_option.length) {
        other_option.find('input[type="checkbox"]').checked = false
        other_option.find('.checkbox label').removeClass('is-primary is-outlined')
        other_option.find('input[type="text"]').val('')
        other_option.find('.other_text').addClass('is-hidden')
      }
    }

    function runThroughRadios(theRadio){
      if (theRadio.val() == 'true') {
        $('.on-true').removeClass('is-hidden');
        clearAllInputs($('.on-false').addClass('is-hidden').find('input'));
      } else {
        $('.on-false').removeClass('is-hidden');
        clearAllInputs($('.on-true').addClass('is-hidden').find('input'));
      }
    }


    function clearRadioInputs(radio_buttons) {
      $(radio_buttons).each(function(index, input) {
        $(input).checked = false;
        $(input).parents('.radio label').removeClass('is-primary is-outlined');
      });
    }

    function clearAllInputs(inputs) {
      $(inputs).each(function() {
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
          $(this).val('');
          break;
        case 'checkbox':
        case 'radio':
          this.checked = false;
          $(this).parents('.checkbox label').removeClass('is-primary is-outlined');
          break;
        }
      });
    }
  }
};
