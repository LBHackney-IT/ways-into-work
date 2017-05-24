$.fn.validate = function() {

  if (this.length === 0) { return false; }

  $(this).bind("change keyup input",function(){
    checkValidation($(this));
  });
};

function checkValidation(input) {
  if (input.hasClass('email')) {
    emailValidate(input);
  } else if(input.hasClass('password')) {
    lengthValidate(input, parseInt(input.data('lengthvalidate')));
    passwordValidate(input.parents('form').find('.password_confirm'), input);
  } else if(input.hasClass('password_confirm')) {
    passwordValidate(input, input.parents('form').find('.password'));
  }
}

function emailValidate(input) {
  if (!isValidEmailAddress(input.val())) {
    setToDanger(input);
  } else {
    setToSuccess(input);
  }
}

function lengthValidate(input, minlength) {

  if (input.val() == '') {
    setToDanger(input);
  } else {
    if(input.val().length >= minlength) {
      setToSuccess(input);
    } else {
      setToDanger(input);
    }
  }
}

function passwordValidate(input, password) {
  if (input.val() != '' && input.val() == password.val()) {
    setToSuccess(input);
  } else {
    setToDanger(input);
  }
}



function setToDanger(input) {
  input.removeClass('is-success').addClass('is-danger');
  input.parents('.field').find('.help').removeClass('hide');
  input.parents('.control').find('.right_icon').addClass('fa-warning').removeClass('fa-check');
}

function setToSuccess(input) {
  input.removeClass('is-danger').addClass('is-success');
  input.parents('.field').find('.help').addClass('hide');
  input.parents('.control').find('.right_icon').addClass('fa-check').removeClass('fa-warning');
}

function isValidEmailAddress(emailAddress) {
  var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
  return pattern.test(emailAddress);
}
