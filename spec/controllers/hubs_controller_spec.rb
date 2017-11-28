require 'spec_helper'

RSpec.describe HubsController, type: :controller do
  render_views
  
  describe '#index' do
    
    let!(:hubs) do
      Fabricate.times(5, :hub) do
        advisors(count: 1) { Fabricate(:advisor_without_hub, team_leader: true) }
      end
    end
    
    it 'gets all hubs' do
      get :index
      
      expect(assigns(:hubs)).to eq(hubs)
    end
    
    it 'lists hubs as geojson' do
      get :index, format: :json
      
      json = JSON.parse(response.body)
      
      expect(json['maps'].count).to eq(5)
      json['maps'].each_with_index do |map, i|
        expect(map['lon']).to eq(hubs[i].longitude)
        expect(map['lat']).to eq(hubs[i].latitude)
        expect(map['hub_id']).to eq(hubs[i].id)
        expect(map['name']).to eq(hubs[i].name)
        expect(map['street']).to eq(hubs[i].address_line_1)
      end
    end
    
  end
  
  
end
