require 'spec_helper'

RSpec.describe Advisor::DashboardController, type: :controller do
  let(:advisor) { Fabricate(:advisor) }
  before { sign_in(advisor.login) }
  
  let(:hub1) { Fabricate(:homerton_hub) }
  let(:hub2) { Fabricate(:hub) }
  
  before do
    Fabricate.times(1, :client, advisor: Fabricate(:advisor, hub: hub1))
    Fabricate.times(2, :client, advisor: Fabricate(:advisor, hub: hub2))
    Fabricate.times(3, :client,
                    advisor: Fabricate(:advisor, hub: hub1),
                    created_at: 1.month.ago)
    Fabricate.times(4, :client,
                    advisor: Fabricate(:advisor, hub: hub2),
                    created_at: 1.month.ago)
  end
  
  describe '#index' do
    
    context 'with defaults' do
      
      let!(:subject) { get :index }
      
      it 'sets the month to this month' do
        expect(assigns(:month)).to eq(Time.zone.today.month)
      end
      
      it 'sets the year to this year' do
        expect(assigns(:year)).to eq(Time.zone.today.year)
      end
      
      it 'does not set a hub' do
        expect(assigns(:hub)).to be_nil
      end
      
      it 'gets a registered count' do
        expect(assigns(:registered)).to eq(3)
      end
      
    end
    
    context 'with hub set' do
      
      let!(:subject) { get :index, params: { hub: hub1.id } }

      it 'gets a registered count' do
        expect(assigns(:registered)).to eq(1)
      end
      
    end
    
    context 'with month set' do
      
      let!(:subject) { get :index, params: { month: 1.month.ago.month } }
      
      it 'gets a registered count' do
        expect(assigns(:registered)).to eq(7)
      end
      
      context 'with hub set' do
        
        let!(:subject) do
          get :index, params: {
            month: 1.month.ago.month,
            hub: hub1.id
          }
        end
        
        it 'gets a registered count' do
          expect(assigns(:registered)).to eq(3)
        end
        
      end
      
    end
    
    it 'sets outcome counts' do
      get :index
      
      expect(assigns(:cv)).to eq(0)
      expect(assigns(:interview)).to eq(0)
      expect(assigns(:work_volunteering_experience)).to eq(0)
      expect(assigns(:job_application)).to eq(0)
      expect(assigns(:training)).to eq(0)
      expect(assigns(:job_apprenticeship)).to eq(0)
      expect(assigns(:sustain_job)).to eq(0)
    end
    
  end
end
