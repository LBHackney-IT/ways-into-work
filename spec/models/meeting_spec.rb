require 'spec_helper'

RSpec.describe Meeting, type: :model do
  let!(:client) { Fabricate(:client) }
  let!(:meeting) { Fabricate(:meeting, client: client, start_datetime: Time.zone.now + 3.days) }

  describe '#add_next_meeting_date_to_client' do
    it 'adds a next meeting date to a client' do
      expect(client.next_meeting_date).to eq(meeting.start_datetime)
    end

    it 'leaves the next meeting date alone' do
      Fabricate(:meeting, start_datetime: Time.zone.now + 1.day, client: client)
      expect(client.next_meeting_date).to eq(meeting.start_datetime)
    end
  end
  
  describe '#set_initial_assessment_date' do
    let!(:meeting) { Fabricate(:meeting, client: client, agenda: 'initial_assessment', client_attended: nil) }

    it 'sets the inital assessment date once a client has been marked as attended' do
      meeting.client_attended = true
      expect { meeting.save }.to change { client.initial_assessment_date }.from(nil).to(meeting.start_datetime.to_date)
    end
  end

  describe 'future scopes' do
    let!(:meeting_tomorrow) do
      Fabricate(:meeting, client: client, start_datetime: Time.zone.now + 1.day)
    end

    it 'finds a meeting two days from now' do
      meetings = Meeting.occurring_tomorrow
      expect(meetings).not_to include(meeting)
      expect(meetings).to include(meeting_tomorrow)
      expect(meetings.count).to eq(1)
    end
  end
end
