require 'spec_helper'

RSpec.describe Achievement, type: :model do
  
  let(:client) { Fabricate(:client) }
  let(:notes) { FFaker::Lorem.sentence }
  let(:date) { Time.zone.today }
  let(:subject) do
    Fabricate(:achievement,
              name: 'placement_volunteering',
              client: client,
              date_acheived: date,
              notes: notes)
  end
  
  it 'has the right columns' do
    expect(subject.name).to eq('placement_volunteering')
    expect(subject.client).to eq(client)
    expect(subject.notes).to eq(notes)
    expect(subject.date_acheived).to eq(date)
  end
  
end
