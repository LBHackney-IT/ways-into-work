require 'spec_helper'

RSpec.describe CustomDeviseMailer, type: :mailer do
  
  describe 'reset_password_instructions' do
    
    let(:mail) { CustomDeviseMailer.reset_password_instructions(client.login, 'sometoken') }
    
    context 'without a referrer' do
      
      let(:client) { Fabricate.create(:client) }
      
      it 'sends the correct body' do
        expect(mail.body.encoded).to match(/Thank you for registering with our service!/)
      end
      
    end
    
    context 'with a referrer' do
      
      let(:client) { Fabricate.create(:client_with_referrer) }

      it 'sends the correct body' do
        expect(mail.body.encoded).to match(/You have been referred to Hackney Works by #{client.referrer.name}/)
      end
      
    end
    
  end
  
end
