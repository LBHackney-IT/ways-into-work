require 'spec_helper'

RSpec.describe Advisor::AdvisorsController, type: :controller do
  
  before { sign_in(advisor.login) }
  
  context 'as an admin' do
    let(:advisor) { Fabricate(:advisor, role: :admin) }
    
    describe '#new' do
      
      it 'returns success' do
        get :new
        expect(response).to have_http_status(:success)
      end
      
    end
    
    describe '#create' do
      
      let(:params) do
        {
          advisor: {
            name: 'Me',
            phone: '12345',
            role: 'advisor',
            hub_id: Fabricate(:hub).id,
            login_attributes: {
              email: 'someone@example.com'
            }
          }
        }
      end
      
      let(:subject) { post :create, params: params }
      let(:created_advisor) { Advisor.last }
      
      it 'creates an advisor' do
        expect { subject }.to change { Advisor.count }.by(1)
      end
      
      it 'creates the correct things' do
        subject
        expect(created_advisor.name).to eq(params[:advisor][:name])
        expect(created_advisor.phone).to eq(params[:advisor][:phone])
        expect(created_advisor.role).to eq(params[:advisor][:role])
        expect(created_advisor.hub_id).to eq(params[:advisor][:hub_id])
        expect(created_advisor.login.email).to eq(params[:advisor][:login_attributes][:email])
      end
      
      it 'sends an email to set a password' do
        subject
        expect(unread_emails_for(created_advisor.login.email).size).to eq(1)
        open_email(created_advisor.login.email)
        expect(current_email).to have_subject(I18n.t('advisors.mail.subject.welcome'))
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
