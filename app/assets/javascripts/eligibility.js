$.fn.checkAccepted = function() {

  if (this.length === 0) { return false; }

  link = $('#register_link .button_to .button');

  checkButton();

  $("#eligibility_check input[type='checkbox']").change(function(){
    checkButton();
  });

  function checkButton() {
    if(allChecked()) {
      $('#register_link').removeClass('disabled');
      $(link).prop("disabled", false);
    } else {
      $('#register_link').addClass('disabled');
      $(link).prop("disabled", true);
    }
  }

  function allChecked() {
    result = true
    $("#eligibility_check").find("input").each(function(){
      if($(this).context.checked == false) {
        result = false;
      }
    })
    return result;
  };

};
