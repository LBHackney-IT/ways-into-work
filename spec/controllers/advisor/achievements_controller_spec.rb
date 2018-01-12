require 'spec_helper'

RSpec.describe Advisor::AchievementsController, type: :controller do
  
  let(:client) { Fabricate(:client) }
  let(:achievements) do
    Fabricate.times(5, :achievement, client: client)
  end
  
  before do
    sign_in(Fabricate(:advisor).login)
  end
  
  describe '#index' do
    
    it 'gets achievements for a client' do
      get :index, params: { client_id: client.id }
      expect(controller.achievements).to eq(achievements)
    end
    
  end
  
  describe '#create' do
    
    let(:subject) do
      post :create, params: {
        client_id: client.id,
        achievement: {
          name: 'cv_completed',
          date_acheived: Time.zone.today,
          notes: 'Some notes'
        }
      }
    end
    
    it 'creates an achievement' do
      expect { subject }.to change { Achievement.count }.by(1)
    end
    
    it 'creates a achievement for the correct client' do
      subject
      expect(Achievement.last.client).to eq(client)
    end
    
    it 'redirects to the achievements page' do
      expect(subject).to redirect_to(advisor_client_achievements_url(client))
    end
    
  end
  
end
