class ServiceManagerMailer < ApplicationMailer

  def notify_client_signed_up(client)
    @client = client
    mail(
      to: UserLogin.service_managers.collect(&:email),
      subject: I18n.t('service_managers.mail.subject.new_client')
    )
  end
end
