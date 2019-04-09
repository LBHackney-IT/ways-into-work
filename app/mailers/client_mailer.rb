class ClientMailer < ApplicationMailer
  def confirm_enquiry(client, opportunity)
    @client = client
    @opportunity = opportunity

    mail(
      to: @client.email,
      subject: I18n.t('clients.mail.subject.confirm_enquiry')
    )
  end
end
