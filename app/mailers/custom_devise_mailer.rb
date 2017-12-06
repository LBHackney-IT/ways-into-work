class CustomDeviseMailer < Devise::Mailer
  default from: WaysIntoWork.config.support_email

  def reset_password_instructions(record, token, opts = {})
    if record.sign_in_count.positive?
      super(record, token, opts)
    else
      welcome_set_password(record, token)
    end
  end

  def welcome_set_password(record, token)
    @user_login = record
    @url = edit_client_password_url(user_login_id: @user_login.id, reset_password_token: token)
    puts @url
    mail(
      to: record.email,
      subject: I18n.t('clients.mail.subject.welcome'),
      template_name: 'welcome_set_password'
    )
  end
end
