require 'spec_helper'

RSpec.describe SmsReminderService, type: :model do
  describe 'send reminders to clients about meetings' do
    let!(:client1) { Fabricate(:client, phone: '07557286509') }
    let!(:client2) { Fabricate(:client, phone: '07557286509', preferred_contact_methods: ['sms_reminder']) }

    let!(:meeting) do
      Fabricate(:meeting, client: client1, start_datetime: Time.zone.now + 1.day)
    end

    let!(:meeting2) do
      Fabricate(:meeting, client: client2, start_datetime: Time.zone.now + 1.day)
    end

    it 'only sends an sms reminder to clients that have opted in', :vcr do
      response = SmsReminderService.new(Meeting.needing_reminder_sms).perform
      expect(response).not_to include(meeting)
      expect(response).to include(meeting2)
    end
  end
end
