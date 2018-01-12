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
  
  describe '#scopes' do
    
    it 'gets achievements by name' do
      Fabricate.times(5, :achievement)
      expect(Achievement.with_name('placement_volunteering')).to match_array([subject])
    end
    
    it 'gets achievements awarded in a time period' do
      achievements = Fabricate.times(5, :achievement) do
        date_acheived(((Time.zone.today - 5.months)..(Time.zone.today - 4.months)).to_a.sample(1).first)
      end
      
      expect(Achievement.acheived_in_period(Time.zone.today - 5.months, Time.zone.today - 4.months)).to match_array(achievements)
    end
    
  end
  
end
