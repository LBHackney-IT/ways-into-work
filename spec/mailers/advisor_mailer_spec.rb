require 'spec_helper'

RSpec.describe AdvisorMailer, type: :mailer do
  
  describe 'notify_client_signed_up' do
    
    let(:mail) { AdvisorMailer.notify_client_signed_up(client) }
    
    context 'without a referrer' do
      
      let(:client) { Fabricate.create(:client) }
      
      it 'sends the correct body' do
        expect(mail.body.encoded).to match(/#{ERB::Util.html_escape(client.name)} has just registered/)
      end
      
    end
    
    context 'with a referrer' do
      
      let(:client) { Fabricate.create(:client_with_referrer) }

      it 'sends the correct body' do
        expect(mail.body.encoded).to match(/#{ERB::Util.html_escape client.name} has just/)
        expect(mail.body.encoded).to match(/been referred to Hackney Works by #{ERB::Util.html_escape client.referrer.name}/)
      end
      
    end
    
  end
  
end
