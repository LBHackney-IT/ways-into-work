# -*- encoding : utf-8 -*-

require 'spec_helper'

RSpec.describe Advisor::ActionPlanTasksController, :vcr, type: :controller do
  describe 'GET index' do
    it "Doesn't allow access to those not logged in" do
      get :index, params: { client_id: '1' }
      expect(response).not_to be_success
      expect(response.code).to eq('302')
    end

    it 'Success after logging in' do
      sign_in(Fabricate(:advisor).login)
      get :index, params: { client_id: Fabricate(:client).id }
      expect(response).to be_success
    end
    
    context 'when logged in' do
      render_views
      before { sign_in(Fabricate(:advisor).login) }
      
      it 'renders the index by default' do
        expect(
          get: :index, params: { client_id: Fabricate(:client).id }
        ).to render_template(:index)
      end
      
      it 'renders the index by default' do
        expect(
          get: :index, params: { client_id: Fabricate(:client).id, print_view: 1 }
        ).to render_template(:index)
      end
      
    end
  
  end
end
