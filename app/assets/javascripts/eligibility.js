$.fn.checkAccepted = function() {

  if (this.length === 0) { return false; }

  link = $('#register_link a')

  $("input[type='checkbox']").change(function(){
    if(allChecked()) {
      $('#register_link').removeClass('disabled')
      $(link).attr('href', 'user_logins/sign_up');
    } else {
      $('#register_link').addClass('disabled')
      $(link).attr('href', '#');
    }
  });

  function allChecked() {
    result = true
    $(".eligibility").find("input").each(function(){
      if($(this).context.checked == false) {
        result =  false
      }
    })
    return result
  };

};
