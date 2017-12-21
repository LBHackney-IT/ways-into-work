require 'spec_helper'

RSpec.describe Advisor::DashboardController, type: :controller do
  let(:hub1) { Fabricate(:homerton_hub) }
  let(:hub2) { Fabricate(:hub) }
  let(:advisor) { Fabricate(:advisor, hub: hub1) }
  let(:advisor2) { Fabricate(:advisor, hub: hub1) }
  
  before { sign_in(advisor.login) }
  
  before do
    Fabricate.times(1, :client, advisor: advisor)
    Fabricate.times(1, :client, advisor: advisor2)
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
        expect(assigns(:registered)).to eq(4)
      end
      
    end
    
    context 'with hub set' do
      
      let!(:subject) { get :index, params: { hub: hub1.id } }

      it 'gets a registered count' do
        expect(assigns(:registered)).to eq(2)
      end
      
    end
    
    context 'with advisor set' do
      
      let!(:subject) { get :index, params: { advisor: advisor.id } }

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
      
      context 'with funding code set' do
        
        it 'gets the correct count' do
          Fabricate.times(3, :client, funded: %w[troubled_families supported_employment])
          Fabricate.times(2, :client, funded: %w[troubled_families])
          get :index, params: {
            funding_code: 'supported_employment'
          }
          expect(assigns(:registered)).to eq(3)
        end
        
      end
      
    end
    
    context 'with quarter set' do
      
      {
        'Q1' => [
          Time.zone.parse('2017-01-01'),
          Time.zone.parse('2017-03-31')
        ],
        'Q2' => [
          Time.zone.parse('2017-04-01'),
          Time.zone.parse('2017-06-30')
        ],
        'Q3' => [
          Time.zone.parse('2017-07-01'),
          Time.zone.parse('2017-09-30')
        ],
        'Q4' => [
          Time.zone.parse('2017-10-01'),
          Time.zone.parse('2017-12-31')
        ]
      }.each do |quarter, dates|
        it "sets the right from and to dates for #{quarter}" do
          get :index, params: {
            month: quarter,
            year: 2017
          }
          expect(assigns(:from)).to eq(dates[0])
          expect(assigns(:to)).to eq(dates[1])
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
