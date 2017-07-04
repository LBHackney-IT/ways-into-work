class AdvisorMailer < ApplicationMailer

  def notify_client_signed_up(client)
    @client = client
    mail(
      to: service_manager_emails(@client),
      subject: I18n.t('advisors.mail.subject.new_client')
    )
  end

  def notify_assigned(client)
    @client = client
    mail(
      to: client.advisor.email,
      subject: I18n.t('advisors.mail.subject.assigned')
    )
  end


  def service_manager_emails(client)
    client.advisor.email
    # (Advisor.admins + [client.advisor]).collect(&:email)
  end
end
