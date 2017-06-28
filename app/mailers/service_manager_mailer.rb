class ServiceManagerMailer < ApplicationMailer

  def notify_client_signed_up(client)
    @client = client
    mail(
      to: service_manager_emails(@client),
      subject: I18n.t('service_managers.mail.subject.new_client')
    )
  end


  def service_manager_emails(client)
    client.advisor.email
    # (Advisor.admins + [client.advisor]).collect(&:email)
  end
end
