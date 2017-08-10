# -*- encoding : utf-8 -*-
require 'spec_helper'

RSpec.describe Advisor::ActionPlanTasksController, type: :controller do

  describe 'GET index' do

    it "Doesn't allow access to those not logged in" do
      get :index, params: { client_id: '1' }
      expect(response).not_to be_success
      expect(response.code).to eq('302')
    end

    it "Success after logging in" do
      sign_in(Fabricate(:advisor).login)
      get :index, params: { client_id: Fabricate(:client).id }
      expect(response).to be_success
    end
  end

end
