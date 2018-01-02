require 'spec_helper'

RSpec.describe HackneyWardFinder, :vcr, type: :model do
  
  it 'returns true if a ward is in Hackney' do
    expect(HackneyWardFinder.new('E5 8DA').lookup).to eq(true)
  end
  
  it 'returns false is a ward is outside Hackney' do
    expect(HackneyWardFinder.new('B74 3UD').lookup).to eq(false)
  end
  
  it 'returns false is a ward is outside Hackney and inside London' do
    expect(HackneyWardFinder.new('N17 6QD').lookup).to eq(false)
  end
  
end
