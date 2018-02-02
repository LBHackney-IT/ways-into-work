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
  
end
