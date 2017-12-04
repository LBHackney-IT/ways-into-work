require 'spec_helper'

RSpec.describe Client, type: :model do
  
  context 'search by name' do
    
    let(:client1) { Fabricate.create(:client, first_name: 'Katherine') }
    let(:client2) { Fabricate.create(:client, last_name: 'Robynson') }
    let(:client3) { Fabricate.create(:client, first_name: 'Muhammad') }

    it 'is not fussy about spellings' do
      expect(Client.search_query('Catherine')).to eq([client1])
      expect(Client.search_query('Robynson')).to eq([client2])
      expect(Client.search_query('Mohammed')).to eq([client3])
    end
    
  end
  

  
end
