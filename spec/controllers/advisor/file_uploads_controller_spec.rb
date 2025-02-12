require 'spec_helper'

RSpec.describe Advisor::FileUploadsController, :vcr, type: :controller do
  
  let(:advisor) { Fabricate(:advisor) }
  before { sign_in(advisor.login) }
  
  describe '#destroy' do
    
    let(:client) { Fabricate(:client) }
    let!(:file_upload) { Fabricate(:file_upload, client: client, uploaded_by: advisor.name, id: 1) }
    let(:subject) { delete :destroy, params: { client_id: client.id, id: file_upload.id } }
    
    it 'destroys a file upload' do
      expect { subject }.to change { FileUpload.count }.by(-1)
    end
    
    it 'redirects' do
      expect(subject).to redirect_to(new_advisor_client_file_upload_path(client))
    end
    
    it 'sets a flash message' do
      subject
      expect(flash[:success]).to eq('File deleted')
    end
    
    it 'deletes the file' do
      subject
      expect(
        a_request(:delete, %r{https:\/\/#{ENV['S3_BUCKET_NAME']}\.s3\.#{ENV['AWS_REGION']}\.amazonaws\.com})
      ).to have_been_made.once
    end
    
  end
  
end
