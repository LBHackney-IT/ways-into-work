require 'spec_helper'
require Rails.root.join('lib', 'seeders', 'client_seeder')

RSpec.describe ClientSeeder, :cli, type: :model do
  
  let(:subject) { ClientSeeder.new('valid.csv') }

  context 'if a CSV is not found' do
    
    let(:subject) { ClientSeeder.new('no.csv') }
    
    it 'outputs an error' do
      expect { subject }.to output("Didn't find file\n").to_stdout
    end
    
    it 'returns an empty array' do
      expect(subject.instance_variable_get('@csv_data')).to eq([])
    end
    
  end
          
  context 'with a new client' do
    
    let!(:rows) { stub_rows }
    
    it 'imports a client successfully' do
      subject.import
      expect(Client.count).to eq(1)
    end
    
    it 'imports the correct data' do
      subject.import
      client = Client.first
      row = rows[0]
      expect(client.advisor_id).to eq(row['Advisor'])
      expect(client.phone).to eq(PhonyRails.normalize_number(row['Contact Number'], country_code: 'GB'))
      expect(client.address_line_1).to eq(row['Address line 1'])
      expect(client.address_line_2).to eq(row['Address line 2'])
      expect(client.rag_status).to eq(row['Current Status (RAGG)'])
      expect(client.gender).to eq(row['Gender'])
      expect(client.receive_benefits).to eq(true)
      expect(client.studying).to eq(false)
      expect(client.employed).to eq(false)
      expect(client.health_conditions).to eq(false)
      expect(client.affected_by_welfare).to eq(true)
      expect(client.assessment_notes.count).to eq(3)
      expect(client.assessment_notes.find_by(content_key: 'job_goal_1').content).to eq(row['Job Goal 1'])
      expect(client.assessment_notes.find_by(content_key: 'job_goal_2').content).to eq(row['Job Goal 2'])
      expect(client.assessment_notes.find_by(content_key: 'general').content).to eq(row['Notes'])
    end
    
    it 'creates a login' do
      subject.import
      login = UserLogin.find_by(email: rows.first['Email Address'])
      expect(login).to_not be_nil
      expect(login.email).to eq(rows.first['Email Address'])
    end
    
    it 'outputs correctly' do
      expect { subject.import }.to output(/importing/).to_stdout
    end
    
  end
  
  context 'with an exisiting client' do
    
    let(:client) { Fabricate(:client, imported: true) }
    
    before do
      stub_rows(1, 'First Name' => client.first_name,
                   'Surname' => client.last_name)
    end
    
    it 'updates an existing client' do
      subject.import
      expect(Client.count).to eq(1)
    end
    
    it 'outputs correctly' do
      expect { subject.import }.to output(/updating existing record/).to_stdout
    end
    
  end
      
  context 'without an email' do
    
    before do
      stub_rows(1, 'First Name' => 'Ian',
                   'Surname' => 'Noemail',
                   'Email Address' => nil)
    end
    
    it 'does not import the client' do
      subject.import
      expect(Client.count).to eq(0)
    end
    
    it 'outputs a warning' do
      expect { subject.import }.to output(
        /Not importing Ian Noemail without an Email Address/
      ).to_stdout
    end
        
  end
  
  context 'without a telephone number' do
    
    before do
      stub_rows(1, 'First Name' => 'Bridget',
                   'Surname' => 'Nophone',
                   'Contact Number' => nil)
    end
    
    it 'does not import the client' do
      subject.import
      expect(Client.count).to eq(0)
    end
    
    it 'outputs a warning' do
      expect { subject.import }.to output(
        /Not importing Bridget Nophone without a Phone Number/
      ).to_stdout
    end
        
  end
end
