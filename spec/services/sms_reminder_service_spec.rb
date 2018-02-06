require 'spec_helper'

RSpec.describe SmsReminderService, type: :model do
  describe 'send reminders to clients about meetings' do
    let!(:client) { Fabricate(:client, phone: '07557286509') }

    let!(:meeting) do
      Fabricate(:meeting, client: client, start_datetime: Time.zone.now + 2.hours)
    end

    it 'sends an sms reminder', :vcr do
      response = SmsReminderService.new(:two_hours_from_now, Meeting.two_hours_from_now).perform
      expect(response).to include(meeting)
    end
  end
end
