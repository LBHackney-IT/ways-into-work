require 'spec_helper'

RSpec.describe ActionPlanTask, type: :model do
  
  describe 'scopes' do
    
    describe 'completed' do
      
      let!(:completed_tasks) { Fabricate.times(4, :action_plan_task, status: 'completed') }
      let!(:incomplete_tasks) { Fabricate.times(5, :action_plan_task) }
      
      it 'gets completed tasks' do
        expect(ActionPlanTask.completed).to eq(completed_tasks)
      end
      
    end
    
    describe 'completed_with_outcome' do
      
      let!(:job_tasks) { Fabricate.times(4, :action_plan_task, status: 'completed', outcome: 'job_apprenticeship') }
      let!(:other_tasks) { Fabricate.times(4, :action_plan_task, status: 'completed') }
      
      it 'gets tasks with job_apprenticeship' do
        expect(ActionPlanTask.completed_with_outcome('job_apprenticeship')).to eq(job_tasks)
      end
      
    end
    
    describe 'for_hub' do
      
      let(:hub1) { Fabricate(:homerton_hub) }
      let(:hub2) { Fabricate(:hub) }
      let(:hub1_clients) { Fabricate.times(5, :client, advisor: Fabricate(:advisor, hub: hub1)) }
      let(:hub2_clients) { Fabricate.times(5, :client, advisor: Fabricate(:advisor, hub: hub2)) }
      
      let!(:hub1_tasks) do
        Fabricate.times(5, :action_plan_task, client: hub1_clients.sample)
      end
      
      let!(:hub2_tasks) do
        Fabricate.times(7, :action_plan_task, client: hub2_clients.sample)
      end
      
      it 'gets tasks for a hub' do
        expect(ActionPlanTask.for_hub(hub1)).to eq(hub1_tasks)
        expect(ActionPlanTask.for_hub(hub2)).to eq(hub2_tasks)
      end
    end
    
  end
  
  
end
