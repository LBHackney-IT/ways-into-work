class ApplicationMailer < ActionMailer::Base
  default from: WaysIntoWork.config.support_email
  layout 'mailer'
end

