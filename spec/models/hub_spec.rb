require 'spec_helper'

RSpec.describe Hub, type: :model do
  
  let(:hub) { Fabricate(:hub) }
  
  context 'managers' do
    it 'are nil by default' do
      expect(hub.manager).to eq(nil)
    end
    
    describe 'can be assigned' do
      let(:manager) { Fabricate(:advisor) }
      before { hub.update(manager: manager) }
      
      it { expect(hub.manager).to eq(manager) }
    end
  end
  
end
