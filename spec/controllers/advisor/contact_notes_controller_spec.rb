require 'spec_helper'

RSpec.describe Advisor::ContactNotesController, type: :controller do
  
  let(:advisor) { Fabricate(:advisor) }
  let(:client) { Fabricate(:client, preferred_contact_methods: ['email']) }
  before { sign_in(advisor.login) }
  
  describe '#index' do
    
    let(:subject) { get :index, params: { client_id: client.id } }
    let!(:contact_notes) { Fabricate.times(5, :contact_note, client: client) }
    
    it 'gets all contact notes' do
      subject
      expect(controller.send(:client).contact_notes).to eq(contact_notes)
    end
    
  end
  
  describe '#new' do
    
    let(:subject) { get :new, params: { client_id: client.id } }
    let(:contact_note) { controller.send(:contact_note) }
    
    it 'initializes a contact note' do
      subject
      expect(contact_note.advisor).to eq(advisor)
      expect(contact_note.client).to eq(client)
    end
    
  end
  
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
  
  describe '#update' do
    
    let(:contact_note) { Fabricate(:contact_note, client: client) }
    
    let(:subject) do
      put :update, params: {
        id: contact_note.id,
        client_id: client.id,
        contact_note: {
          contact_method: 'Email',
          content: 'Some Content'
        }
      }
    end
    
    it 'updates a contact note' do
      subject
      contact_note.reload
      expect(contact_note.contact_method).to eq('Email')
      expect(contact_note.content).to eq('Some Content')
    end
    
  end
  
end
