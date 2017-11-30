# :nocov:
class AdvisorMailerPreview < ActionMailer::Preview
  def notify_client_signed_up
    AdvisorMailer.notify_client_signed_up(Fabricate.build(:client))
  end

  def notify_assigned
    AdvisorMailer.notify_assigned(Fabricate.build(:client))
  end
end
# :nocov:
