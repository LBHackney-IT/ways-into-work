class CustomDeviseMailer < Devise::Mailer
  default from: WaysIntoWork.config.support_email
  layout 'mailer'

  def reset_password_instructions(record, token, opts = {})
    if record.sign_in_count.positive?
      super(record, token, opts)
    else
      welcome_set_password(record, token)
    end
  end

  def welcome_set_password(record, token)
    user_type = record.user_type.downcase.pluralize

    @user_login = record
    @user = record.user
    @url = get_url(user_type, record, token)
      
    logger.info @url
    mail(
      to: record.email,
      subject: I18n.t("#{user_type}.mail.subject.welcome"),
      template_name: "#{user_type}/welcome_set_password"
    )
  end
  
  def get_url(user_type, login, token)
    if user_type == 'clients'
      edit_client_password_url(user_login_id: login.id, reset_password_token: token)
    else
      edit_user_login_password_url(login, reset_password_token: token)
    end
  end
  
end
