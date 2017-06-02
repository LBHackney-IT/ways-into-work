class CustomDeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views


  def reset_password_instructions(record, token, opts={})
    if record.sign_in_count > 0
      super(record, token, opts={})
    else
      welcome_set_password(record, token)
    end
  end

  def welcome_set_password(record, token)
    @token = token
    @user_login = record
    mail(
        to: @user_login.email,
        subject: I18n.t('clients.mail.subject.welcome'),
        template_name: "welcome_set_password"
    )
  end
end
