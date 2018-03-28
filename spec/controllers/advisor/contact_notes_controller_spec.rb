require 'spec_helper'

RSpec.describe Advisor::ContactNotesController, type: :controller do
  
  let(:advisor) { Fabricate(:advisor) }
  let(:client) { Fabricate(:client) }
  before { sign_in(advisor.login) }
  
  describe '#create' do
    
    let(:subject) do
      post :create, params: {
        client_id: client.id,
        contact_note: {
          contact_method: 'Email',
          content: 'Some Content',
          client_id: client.id,
          advisor_id: advisor.id
        }
      }
    end
    
    context 'with an advisor' do
      
      let(:advisor) { Fabricate(:advisor, role: :advisor) }

      it 'redirects to the correct path' do
        subject
        expect(response).to redirect_to(advisor_my_clients_path)
      end
      
    end

    context 'with an admin' do
      let(:advisor) { Fabricate(:advisor, role: :admin) }

      it 'redirects to the correct path' do
        subject
        expect(response).to redirect_to(advisor_clients_path)
      end
      
    end
    
  end
  
end
