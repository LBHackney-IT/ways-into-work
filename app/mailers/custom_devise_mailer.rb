class CustomDeviseMailer < Devise::Mailer

  default from: WaysIntoWork.config.support_email

  # include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

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
