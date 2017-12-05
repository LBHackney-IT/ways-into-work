require 'spec_helper'

RSpec.describe Advisor::ClientsController, type: :controller do
  
  let(:advisor) { Fabricate(:advisor) }
  before { sign_in(advisor.login) }
  
  describe '#update' do
    
    let(:client) { Fabricate(:client) }
    
    it 'updates a client\'s contact details' do
      put :update, params: {
        id: client.id,
        client: {
          email: 'something@somewhere.com',
          phone: '01213539609',
          address_line_1: '123 Fake Street',
          address_line_2: 'London',
          postcode: 'SW1A 1AA'
        }
      }
      
      client.reload
      
      expect(client.email).to eq('something@somewhere.com')
      expect(client.phone).to eq('+441213539609')
      expect(client.address_line_1).to eq('123 Fake Street')
      expect(client.address_line_2).to eq('London')
      expect(client.postcode).to eq('SW1A 1AA')
    end
    
  end
  
end
