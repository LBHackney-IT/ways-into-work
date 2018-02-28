require 'spec_helper'

RSpec.describe ReferrerMailer, type: :mailer do
  
  let(:client) { Fabricate(:client) }
  let(:referrer) { Fabricate(:referrer, client: client) }

  describe 'notify_client_signed_up' do
    
    let(:mail) { ReferrerMailer.confirmation_email(referrer) }
  
    it 'sends to the referrer' do
      expect(mail.to).to eq([referrer.email])
    end
    
    it 'includes the referrer name' do
      expect(mail.body.encoded).to include("Hi, #{referrer.name}")
    end
    
    it 'includes the client name' do
      expect(mail.body.encoded).to include("Thank you for referring #{client.name} to the Hackney Works service")
    end
    
  end
  
end
