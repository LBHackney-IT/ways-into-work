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
    
  end
  
end
