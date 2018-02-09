require 'spec_helper'

RSpec.describe SmsReminderService, type: :model do
  describe 'send reminders to clients about meetings' do
    let!(:client) { Fabricate(:client, phone: '07557286509') }

    let!(:meeting) do
      Fabricate(:meeting, client: client, start_datetime: Time.zone.now + 1.day)
    end

    it 'sends an sms reminder', :vcr do
      response = SmsReminderService.new(Meeting.occurring_tomorrow).perform
      expect(response).to include(meeting)
    end
  end
end
