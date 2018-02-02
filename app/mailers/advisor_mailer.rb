class AdvisorMailer < ApplicationMailer
  def notify_client_signed_up(client)
    @client = client
    mail(
      to: @client.advisor.email,
      subject: I18n.t('advisors.mail.subject.new_client')
    )
  end

  def notify_assigned(client, assigned_by)
    @client = client
    @assigned_by = assigned_by
    mail(
      to: client.advisor.email,
      subject: I18n.t('advisors.mail.subject.assigned')
    )
  end
end
