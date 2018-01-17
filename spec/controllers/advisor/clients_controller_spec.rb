require 'spec_helper'

RSpec.describe Advisor::ClientsController, type: :controller do
  
  let(:advisor) { Fabricate(:advisor) }
  before { sign_in(advisor.login) }
  
  describe '#index' do
    
    let!(:clients) { Fabricate.times(10, :client) }
        
    it 'generates a csv' do
      get :index, format: :csv
      csv = CSV.parse response.body
      expect(csv.count).to eq(11)
      expect(csv.shift).to eq(Client.csv_header)
      expect(csv).to eq(clients.map(&:csv_row))
    end
    
  end
  
  describe '#update' do
    
    let(:client) { Fabricate(:client) }
    
    it 'updates a client\'s contact details' do
      put :update, params: {
        id: client.id,
        client: {
          first_name: 'New',
          last_name: 'Name',
          email: 'something@somewhere.com',
          phone: '01213539609',
          address_line_1: '123 Fake Street',
          address_line_2: 'London',
          postcode: 'SW1A 1AA'
        }
      }
      
      client.reload
      
      expect(client.first_name).to eq('New')
      expect(client.last_name).to eq('Name')
      expect(client.email).to eq('something@somewhere.com')
      expect(client.phone).to eq('+441213539609')
      expect(client.address_line_1).to eq('123 Fake Street')
      expect(client.address_line_2).to eq('London')
      expect(client.postcode).to eq('SW1A 1AA')
    end
    
  end
  
end
