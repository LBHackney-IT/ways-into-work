# :nocov:
class DeviseMailerPreview < ActionMailer::Preview

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions((Client.last || Fabricate.build(:client)).login, 'test')
  end
end
# :nocov:
