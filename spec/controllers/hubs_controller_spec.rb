require 'spec_helper'

RSpec.describe HubsController, type: :controller do
  render_views
  
  describe '#index' do
    
    let!(:hubs) do
      Fabricate.times(5, :hub) do
        advisors(count: 1) { Fabricate(:advisor_without_hub, role: :team_leader) }
      end
    end
    
    it 'gets all hubs' do
      get :index
      
      expect(controller.hubs).to eq(hubs)
    end
    
  end
  
  
end
