require 'notifications/client'

class SmsReminderService
  include Rails.application.routes.url_helpers

  NOTIFICATIONS_CLIENT = Notifications::Client.new(WaysIntoWork.config.notify_api_key)

  def initialize(meetings)
    @meetings = meetings
  end

  def perform
    @meetings.each do |meeting|
      send_sms(meeting)
    end
  end

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  private

  def send_sms(meeting, client = meeting.client, advisor = meeting.advisor)
    NOTIFICATIONS_CLIENT.send_sms(
      phone_number: client.phone,
      template_id: '70f6abd0-5831-42b1-b8b4-5c749ef30de1',
      personalisation: {
        first_name: client.first_name,
        advisor_name: advisor.name,
        location_and_time: "#{client.hub.address_to_s}, tomorrow #{meeting.start_datetime.to_s(:at_time)}",
        contact_url: hubs_url
      }
      # reference: "your_reference_string", If we want to track success/fail
    )
  end
end
