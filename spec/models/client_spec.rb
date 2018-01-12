require 'spec_helper'

RSpec.describe Client, type: :model do
  
  context 'search by name' do
    
    let(:client1) { Fabricate.create(:client, first_name: 'Katherine') }
    let(:client2) { Fabricate.create(:client, last_name: 'Robynson') }
    let(:client3) { Fabricate.create(:client, first_name: 'Muhammad') }

    it 'is not fussy about spellings' do
      expect(Client.search_query('Catherine')).to match_array([client1])
      expect(Client.search_query('Robynson')).to match_array([client2])
      expect(Client.search_query('Mohammed')).to match_array([client3])
      expect(Client.search_query('muhammad')).to match_array([client3])
    end
  
  end

  describe 'scopes' do
    
    let(:new_date) do
      rand(Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
    end
    
    let(:old_date) do
      rand(1.month.ago.beginning_of_month..1.month.ago.end_of_month)
    end
    
    describe 'by_hub_id' do
      
      let(:hub1) { Fabricate(:homerton_hub) }
      let(:hub2) { Fabricate(:hub) }
      let!(:hub1_clients) do
        Fabricate.times(5, :client,
                        advisor: Fabricate(:advisor, hub: hub1))
      end
      let!(:hub2_clients) do
        Fabricate.times(5, :client,
                        advisor: Fabricate(:advisor, hub: hub2))
      end
      
      it 'gets clients for a hub' do
        expect(Client.by_hub_id(hub1.id)).to eq(hub1_clients)
        expect(Client.by_hub_id(hub2.id)).to eq(hub2_clients)
      end
      
    end
    
    describe 'registered_on' do
      
      let!(:new_clients) { Fabricate.times(5, :client, created_at: new_date) }
      
      let!(:old_clients) { Fabricate.times(5, :client, created_at: old_date) }
      
      it 'gets clients registered this month' do
        expect(Client.registered_on(Time.zone.now)).to eq(new_clients)
      end
      
      it 'gets clients registered last month' do
        expect(Client.registered_on(1.month.ago)).to eq(old_clients)
      end
      
      it 'gets clients registered within a date range' do
        expect(
          Client.registered_on(old_date.beginning_of_day, new_date.end_of_day)
        ).to match(new_clients + old_clients)
      end
      
    end
    
    describe 'with_outcome' do
      
      let!(:job_start_clients) do
        Fabricate.times(4, :client) do
          action_plan_tasks do
            [
              Fabricate(:action_plan_task,
                        outcome: 'job_apprenticeship',
                        status: 'completed',
                        ended_at: rand(Time.zone.now.beginning_of_month..Time.zone.now.end_of_month))
            ]
          end
        end
      end
      
      let!(:old_job_start_clients) do
        ActionPlanTask.skip_callback(:save, :before, :check_completion)
        clients = Fabricate.times(8, :client) do
          action_plan_tasks do
            [
              Fabricate(:action_plan_task,
                        outcome: 'job_apprenticeship',
                        status: 'completed',
                        ended_at: rand(1.month.ago.beginning_of_month..1.month.ago.end_of_month))
            ]
          end
        end
        ActionPlanTask.set_callback(:save, :before, :check_completion)
        clients
      end
      
      
      it 'gets clients with a job start' do
        expect(
          Client.with_outcome('job_apprenticeship', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
        ).to match_array(job_start_clients)
        
        expect(
          Client.with_outcome('job_apprenticeship', 1.month.ago.beginning_of_month, 1.month.ago.end_of_month)
        ).to match_array(old_job_start_clients)
      end
    end
    
    describe 'by_funding_code' do
      
      let!(:clients) { Fabricate.times(5, :client, funded: %w[troubled_families supported_employment]) }
      let!(:other_clients) { Fabricate.times(5, :client, funded: %w[supported_employment]) }
      
      it 'gets the correct clients' do
        expect(Client.by_funding_code('troubled_families')).to eq(clients)
        expect(Client.by_funding_code('supported_employment')).to eq(clients + other_clients)
      end
      
      it 'gets all by default' do
        expect(Client.by_funding_code(nil)).to eq(clients + other_clients)
      end
      
    end
    
  end
  
  it 'can have a referrer' do
    referrer = Fabricate.create(:referrer)
    client = Fabricate.create(:client, referrer: referrer)
    expect(client.referrer).to eq(referrer)
  end
end
