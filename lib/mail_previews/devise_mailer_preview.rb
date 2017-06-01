class DeviseMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    Devise::Mailer.confirmation_instructions((Client.last || Fabricate.build(:client)).login, "AToken")
  end

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions((Client.last || Fabricate.build(:client)).login, 'test')
  end
end
