require 'spec_helper'

RSpec.describe Advisor, type: :model do
  
  let(:subject) { Fabricate.create(:advisor) }
  
  describe 'default_hub_id' do
    
    it 'shows the hub id by default' do
      expect(subject.default_hub_id).to eq(subject.hub_id)
    end
    
    it 'returns if a user is an admin' do
      subject.role = :admin
      expect(subject.default_hub_id).to eq(nil)
    end
    
  end
  
  
end
