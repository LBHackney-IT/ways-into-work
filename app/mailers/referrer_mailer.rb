class ReferrerMailer < ApplicationMailer
  default from: WaysIntoWork.config.support_email
  
  def confirmation_email(referrer)
    @referrer = referrer
    mail(
      to: @referrer.email,
      subject: I18n.t('referrers.mail.subject.confirmation')
    )
  end
  
end
