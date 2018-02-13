require 'spec_helper'

RSpec.describe Advisor::AdvisorController, type: :controller do
  
  before { sign_in(advisor.login) }
  
  context 'as an admin' do
    let(:advisor) { Fabricate(:advisor, role: :admin) }
    
    describe '#new' do
      
      it 'returns success' do
        get :new
        expect(response).to have_http_status(:success)
      end
      
    end
  end
  
  context 'as an advisor' do
    let(:advisor) { Fabricate(:advisor, role: :advisor) }
    
    describe '#new' do
      
      it 'returns forbidden' do
        get :new
        expect(response).to have_http_status(:redirect)
      end
      
    end
  end
  
end
