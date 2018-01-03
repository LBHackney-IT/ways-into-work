require 'spec_helper'

RSpec.describe HackneyWardFinder, :vcr, type: :model do
  
  let(:subject) { HackneyWardFinder.new(postcode) }
  
  context 'in Hackney' do
    
    let(:postcode) { 'E5 8DA' }
    
    it 'returns a ward code' do
      expect(subject.lookup).to eq('144385')
    end
    
    it 'returns true' do
      expect(subject.in_hackney?).to eq(true)
    end
    
  end
  
  context 'outside Hackney' do
    
    let(:postcode) { 'B74 3UD' }
    
    it 'returns nil' do
      expect(subject.lookup).to eq(nil)
    end
    
    it 'returns false' do
      expect(subject.in_hackney?).to eq(false)
    end
    
  end
  
  context 'outside Hackney and in London' do
  
    let(:postcode) { 'SW1A 1AA' }
    
    it 'returns nil' do
      expect(subject.lookup).to eq(nil)
    end
    
    it 'returns false' do
      expect(subject.in_hackney?).to eq(false)
    end
    
  end
  
end
