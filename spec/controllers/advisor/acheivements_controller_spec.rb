require 'spec_helper'

RSpec.describe Advisor::AcheivementsController, type: :controller do
  
  let(:client) { Fabricate(:client) }
  let(:acheivements) do
    Fabricate.times(5, :acheivement, client: client)
  end
  
  before do
    sign_in(Fabricate(:advisor).login)
  end
  
  describe '#index' do
    
    it 'gets acheivements for a client' do
      get :index, params: { client_id: client.id }
      expect(controller.acheivements).to eq(acheivements)
    end
    
  end
  
  describe '#create' do
    
    let(:subject) do
      post :create, params: {
        client_id: client.id,
        acheivement: {
          name: 'cv_completed',
          date_acheived: Time.zone.today,
          notes: 'Some notes'
        }
      }
    end
    
    it 'creates an acheivement' do
      expect { subject }.to change { Acheivement.count }.by(1)
    end
    
    it 'creates a acheivement for the correct client' do
      subject
      expect(Acheivement.last.client).to eq(client)
    end
    
    it 'redirects to the acheivements page' do
      expect(subject).to redirect_to(advisor_client_acheivements_url(client))
    end
    
  end
  
end
