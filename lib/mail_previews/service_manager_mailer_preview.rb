class ServiceManagerMailerPreview < ActionMailer::Preview

  def notify_client_signed_up
    ServiceManagerMailer.notify_client_signed_up(Fabricate.build(:client))
  end
end
