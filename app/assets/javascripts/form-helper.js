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
        }
      });
    });
  }

  convertRadio = $(this).find('.convert_radio')

  if (convertRadio.length) {
    convertRadio.find('input[type=radio]').each(function() {
      if ($(this).is(':checked')) {
        $(this).parents('.radio label').addClass('is-primary is-outlined');
        if(!$(this).parents('.convert_radio').hasClass('radio_child')) {
          runThroughRadios($(this));
        }
      }
    });
    convertRadio.find('input[type=radio]').change(function() {
      $(this).parents('.convert_radio').find('.is-primary').removeClass('is-primary is-outlined');
      $(this).parents('.radio label').addClass('is-primary is-outlined');
      console.log($(this).parents('.convert_radio').hasClass('radio_child'))
      if(!$(this).parents('.convert_radio').hasClass('radio_child')) {
        runThroughRadios($(this));
      }
    });

    function runThroughRadios(theRadio){
      if (theRadio.val() == 'true') {
        $('.on-true').removeClass('is-hidden');
        clearAllInputs($('.on-false').addClass('is-hidden').find('input'));
      } else {
        $('.on-false').removeClass('is-hidden');
        clearAllInputs($('.on-true').addClass('is-hidden').find('input'));
      }
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
          jQuery(this).val('');
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
